import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/form_submission_model.dart';
import 'package:venue_flow_app/models/form_page_model.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/theme/editorial_theme_data.dart';
import 'package:venue_flow_app/views/reordeable_form_fields_list.dart';

class ViewFormPage extends ConsumerStatefulWidget {
  final String? formId;
  const ViewFormPage({super.key, this.formId});

  @override
  ConsumerState<ViewFormPage> createState() => _ViewFormPageState();
}

class _ViewFormPageState extends ConsumerState<ViewFormPage> {
  int _currentPageIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formValues = <String, dynamic>{};

  void _updateFormValue(MapEntry<String, dynamic> entry) {
    _formValues[entry.key] = entry.value;
  }

  void _saveFormValue(MapEntry<String, dynamic> entry) {
    _formValues[entry.key] = entry.value;
  }

  Future<void> _handleNext() async {
    final formState = _formKey.currentState;
    if (formState == null) {
      return;
    }

    if (!formState.validate()) {
      return;
    }

    formState.save();

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Future<void> _handleSubmit() async {
  //   final formState = _formKey.currentState;
  //   if (formState == null) {
  //     return;
  //   }

  //   if (!formState.validate()) {
  //     return;
  //   }

  //   formState.save();

  //   final formViewState = ref.read(formViewBuilderViewModelProvider);
  //   final currentForm = formViewState.form.isNotEmpty ? formViewState.form.first : null;
  //   final currentUser = ref.read(formViewBuilderViewModelProvider.notifier).currentUser;

  //   if (currentForm == null || currentUser == null) {
  //     return;
  //   }

  //   final submission = FormSubmission.fromFormValues(
  //     form: currentForm,
  //     user: currentUser,
  //     values: _formValues,
  //   );

  //   log('FORM VALUES :: $_formValues');
  //   log('FORM SUBMISSION :: ${submission.toJson()}');

  //   if (!mounted) {
  //     return;
  //   }

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Captured ${_formValues.length} field values.')),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(formViewBuilderViewModelProvider.notifier).loadForm(
          // formId: widget.formId ?? '',
          );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formViewBuilderViewModelProvider);
    final form = formState.form.isNotEmpty ? formState.form.first : null;
    final pages = form?.schema ?? const <FormPageModel>[];

    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    if (formState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (form == null || pages.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No form available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(form.name ?? 'Form Viewer'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 68,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                scrollDirection: Axis.horizontal,
                itemCount: pages.length,
                separatorBuilder: (_, __) => const SizedBox(
                  width: 20,
                  child: Divider(),
                ),
                itemBuilder: (context, index) {
                  final isSelected = index == _currentPageIndex;
                  return InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primaryContainer
                            : colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.surfaceContainerHigh,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          pages[index].title ?? 'Page ${index + 1}',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: isSelected
                                        ? colorScheme.onPrimary
                                        : colorScheme.onSurfaceVariant,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                pages[_currentPageIndex].title ??
                    'Page ${_currentPageIndex + 1}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      _buildFormPage(
                        pageIndex: index,
                        page: pages[index],
                        colorScheme: colorScheme,
                        editorial: editorial,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          color: colorScheme.surface,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _formKey.currentState?.reset();
                                      _formValues.clear();
                                      setState(() {});
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton(
                                    onPressed: index == 0
                                        ? null
                                        : () {
                                            _pageController.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                    child: const Text('Back'),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: index == (pages.length - 1)
                                    ? () {
                                        ref
                                            .watch(
                                                formViewBuilderViewModelProvider
                                                    .notifier)
                                            .handleSubmit(formKey: _formKey,formValues:_formValues);
                                      }
                                    : _handleNext,
                                child: Text(
                                  index == (pages.length - 1)
                                      ? 'Submit'
                                      : 'Next',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormPage({
    required int pageIndex,
    required FormPageModel page,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
  }) {
    return CustomScrollView(
      controller: _scrollController, // Add scroll controller here
      slivers: [
        // Form Fields List as Sliver
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Card(
              color: colorScheme.surfaceContainer,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: ReorderableFormFieldsList(
                    pageIndex: pageIndex,
                    fields: page.fields ?? [],
                    fieldValues: _formValues,
                    onFieldChanged: _updateFormValue,
                    onFieldSaved: _saveFormValue,
                    colorScheme: colorScheme,
                    editorial: editorial,
                    isClient: true,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Add some bottom padding for better scrolling
        const SliverPadding(
          padding: EdgeInsets.only(bottom: 100),
        ),
      ],
    );
  }
}

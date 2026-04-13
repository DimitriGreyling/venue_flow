import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              pages[_currentPageIndex].title ?? 'Page ${_currentPageIndex + 1}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildFormPage(pages[index], colorScheme, editorial);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormPage(FormPageModel page, ColorScheme colorScheme,
      EditorialThemeData editorial) {
    return CustomScrollView(
      controller: _scrollController, // Add scroll controller here
      slivers: [
        // Form Fields List as Sliver
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: ReorderableFormFieldsList(
                  fields: page.fields ?? [],
                  colorScheme: colorScheme,
                  editorial: editorial,
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

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomCheckBoxGroup<T> extends FormBuilderFieldDecoration<List<T>> {
  final List<FormBuilderFieldOption<T>> options;

  CustomCheckBoxGroup({
    super.key,
    required super.name,
    required this.options,
  }) : super(
          builder: (FormFieldState<List<T>?> field) {
            final state = field as _CustomCheckBoxGroupState<T>;
            return InputDecorator(
              decoration: state.decoration,
              child: SingleChildScrollView(
                child: _CustomGroupedCheckBox<T>(
                  options: options,
                  value: field.value ?? [],
                  onChanged: (val) {
                    field.didChange(val);
                  },
                ),
              ),
            );
          },
        );

  @override
  FormBuilderFieldDecorationState<CustomCheckBoxGroup<T>, List<T>>
      createState() => _CustomCheckBoxGroupState<T>();
}

class _CustomCheckBoxGroupState<T>
    extends FormBuilderFieldDecorationState<CustomCheckBoxGroup<T>, List<T>> {}

class _CustomGroupedCheckBox<T> extends StatelessWidget {
  /// The list of items the user can select
  final List<FormBuilderFieldOption<T>> options;
  final List<T> value;
  final ValueChanged<List<T>> onChanged;

  final Axis direction;
  final double spacing;
  final bool expanded;

  /// Creates a list of `Chip`s that acts like radio buttons
  const _CustomGroupedCheckBox({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.direction = Axis.horizontal,
    this.spacing = 0.0,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing, // Horizontal spacing between the children
      runSpacing: spacing, // Vertical spacing between the lines
      children: options.map((FormBuilderFieldOption<T> option) {
        return Builder(builder: (context) {
          return SelectOptionsWrapper(
            isSelected: value.contains(option.value),
            child: InkWell(
              onTap: () {
                List<T> selectedListItems = List.of(value);
                selectedListItems.contains(option.value)
                    ? selectedListItems.remove(option.value)
                    : selectedListItems.add(option.value);
                onChanged(selectedListItems);
              },
              child: option,
            ),
          );
        });
      }).toList(),
    );
  }
}

class SelectOptionsWrapper extends StatefulWidget {
  final bool isSelected;
  final Widget child;

  const SelectOptionsWrapper({
    super.key,
    required this.isSelected,
    required this.child,
  });

  @override
  State<SelectOptionsWrapper> createState() => _SelectOptionsWrapperState();
}

class _SelectOptionsWrapperState extends State<SelectOptionsWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.isSelected ? EdgeInsets.zero : const EdgeInsets.all(4),
      padding: !widget.isSelected ? EdgeInsets.zero : const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isSelected ? Colors.red : Colors.grey,
          width: 1.0,
        ),
      ),
      child: widget.child,
    );
  }
}

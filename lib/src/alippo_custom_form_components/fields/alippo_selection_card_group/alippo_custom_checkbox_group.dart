import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'comp/selection_card.dart';

/// A list of `Chip`s that acts like radio buttons
class AlippoCustomCheckBoxGroup<T> extends FormBuilderFieldDecoration<List<T>> {
  /// The list of items the user can select.
  final List<SelectionCardOption<T>> options;

  // FilterChip Settings
  /// Elevation to be applied on the chip relative to its parent.
  ///
  /// This controls the size of the shadow below the chip.
  ///
  /// Defaults to 0. The value is always non-negative.
  final double? elevation;

  /// Elevation to be applied on the chip relative to its parent during the
  /// press motion.
  ///
  /// This controls the size of the shadow below the chip.
  ///
  /// Defaults to 8. The value is always non-negative.
  final double? pressElevation;

  /// Color to be used for the chip's background, indicating that it is
  /// selected.
  final Color? selectedCardColor;

  /// Color to be used for the chip's background indicating that it is disabled.
  ///
  /// The chip is disabled when [isEnabled] is false, or all three of
  /// [SelectableChipAttributes.onSelected], [TappableChipAttributes.onPressed],
  /// and [DeletableChipAttributes.onDelete] are null.
  ///
  /// It defaults to [Colors.black38].
  final Color? disabledColor;

  final Color? defaultCardColor;

  /// Color of the chip's shadow when the elevation is greater than 0 and the
  /// chip is selected.
  ///
  /// The default is [Colors.black].
  final Color? selectedShadowColor;

  /// Color of the chip's shadow when the elevation is greater than 0.
  ///
  /// The default is [Colors.black].
  final Color? shadowColor;

  /// The [OutlinedBorder] to draw around the chip.
  ///
  /// Defaults to the shape in the ambient [ChipThemeData]. If the theme
  /// shape resolves to null, the default is [StadiumBorder].
  ///
  /// This shape is combined with [side] to create a shape decorated with an
  /// outline. If it is a [MaterialStateOutlinedBorder],
  /// [MaterialStateProperty.resolve] is used for the following
  /// [MaterialState]s:
  ///
  ///  * [MaterialState.disabled].
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.pressed].
  final OutlinedBorder? selectedShape;

  final OutlinedBorder? unselectedShape;

  /// The padding around the [label]
  ///
  /// By default, this is 4 logical pixels at the beginning and the end of the
  /// label, and zero on top and bottom.
  final EdgeInsets? labelPadding;

  /// The style to be applied to the chip's label.
  ///
  /// If null, the value of the [ChipTheme]'s [ChipThemeData.labelStyle] is used.
  //
  /// This only has an effect on widgets that respect the [DefaultTextStyle],
  /// such as [Text].
  ///
  /// If [labelStyle.color] is a [MaterialStateProperty<Color>], [MaterialStateProperty.resolve]
  /// is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.disabled].
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.pressed].
  final TextStyle? selectedLabelStyle;

  final TextStyle? unselectedLabelStyle;

  /// The padding between the contents of the chip and the outside [selectedShape].
  ///
  /// Defaults to 4 logical pixels on all sides.
  final EdgeInsets? padding;

  /// The direction to use as the main axis when wrapping chips.
  ///
  /// For example, if [direction] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another in a horizontal run until the
  /// available horizontal space is consumed, at which point a subsequent
  /// children are placed in a new run vertically adjacent to the previous run.
  final Axis direction;

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// If there is additional free space in a run (e.g., because the wrap has a
  /// minimum size that is not filled or because some runs are longer than
  /// others), the additional free space will be allocated according to the
  /// [alignment].
  ///
  /// Defaults to 0.0.
  final double spacing;

  final bool expanded;

  final Duration? animationDuration;

  final Duration? reverseAnimationDuration;

  final Curve? animationCurve;

  final Curve? reverseAnimationCurve;

  AlippoCustomCheckBoxGroup({
    super.autovalidateMode = AutovalidateMode.disabled,
    super.enabled,
    super.focusNode,
    super.onSaved,
    super.validator,
    super.decoration,
    super.key,
    required super.name,
    required this.options,
    super.initialValue,
    super.restorationId,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    this.defaultCardColor,
    this.direction = Axis.horizontal,
    this.disabledColor,
    this.elevation,
    this.labelPadding,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.padding,
    this.pressElevation,
    this.selectedCardColor,
    this.selectedShadowColor,
    this.shadowColor,
    this.selectedShape,
    this.unselectedShape,
    this.spacing = 0.0,
    this.expanded = false,
    this.animationDuration,
    this.reverseAnimationDuration,
    this.animationCurve,
    this.reverseAnimationCurve,
  }) : super(
          builder: (FormFieldState<List<T>?> field) {
            final state = field as _AlippoCustomCheckBoxGroupState<T>;

            return InputDecorator(
              decoration: state.decoration,
              child: SingleChildScrollView(
                child: CustomGroupedCheckBox<T>(
                  options: options,
                  value: field.value ?? [],
                  onChanged: (val) {
                    field.didChange(val);
                  },
                  selectedCardColor: selectedCardColor,
                  defaultCardColor: defaultCardColor,
                  disabledColor: disabledColor,
                  shadowColor: shadowColor,
                  selectedShadowColor: selectedShadowColor,
                  elevation: elevation,
                  pressElevation: pressElevation,
                  selectedLabelStyle: selectedLabelStyle,
                  unselectedLabelStyle: unselectedLabelStyle,
                  labelPadding: labelPadding,
                  padding: padding,
                  selectedShape: selectedShape,
                  unselectedShape: unselectedShape,
                  expanded: expanded,
                  spacing: spacing,
                ),
              ),
            );
          },
        );

  @override
  FormBuilderFieldDecorationState<AlippoCustomCheckBoxGroup<T>, List<T>>
      createState() => _AlippoCustomCheckBoxGroupState<T>();
}

class _AlippoCustomCheckBoxGroupState<T>
    extends FormBuilderFieldDecorationState<AlippoCustomCheckBoxGroup<T>,
        List<T>> {}

class CustomGroupedCheckBox<T> extends StatelessWidget {
  /// The list of items the user can select
  final List<SelectionCardOption<T>> options;

  /// A list of string which specifies automatically checked checkboxes.
  /// Every element must match an item from itemList.
  final List<T> value;

  /// Specifies which checkbox option values should be disabled.
  /// If this is null, then no checkbox options will be disabled.
  final List<T> disabled;

  /// Called when the value of the checkbox group changes.
  final ValueChanged<List<T>> onChanged;
  final double? elevation;
  final double? pressElevation;
  final Color? selectedCardColor;
  final Color? disabledColor;

  final Color? defaultCardColor;

  final Color? selectedShadowColor;
  final Color? shadowColor;
  final OutlinedBorder? selectedShape;

  final OutlinedBorder? unselectedShape;

  final EdgeInsets? labelPadding;

  final TextStyle? selectedLabelStyle;

  final TextStyle? unselectedLabelStyle;

  final EdgeInsets? padding;
  final Axis direction;
  final double spacing;

  final bool expanded;

  final Duration? animationDuration;

  final Duration? reverseAnimationDuration;

  final Curve? animationCurve;

  final Curve? reverseAnimationCurve;

  /// Creates a list of `Chip`s that acts like radio buttons
  const CustomGroupedCheckBox({
    super.key,
    required this.options,
    this.value = const [],
    required this.onChanged,
    this.disabled = const [],
    this.defaultCardColor,
    this.direction = Axis.horizontal,
    this.disabledColor,
    this.elevation,
    this.labelPadding,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.padding,
    this.pressElevation,
    this.selectedCardColor,
    this.selectedShadowColor,
    this.shadowColor,
    this.selectedShape,
    this.unselectedShape,
    this.spacing = 0.0,
    this.expanded = false,
    this.animationDuration,
    this.reverseAnimationDuration,
    this.animationCurve,
    this.reverseAnimationCurve,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing, // Horizontal spacing between the children
      runSpacing: spacing, // Vertical spacing between the lines
      children: options.map((SelectionCardOption<T> option) {
        return Builder(builder: (context) {
          final isOptionDisabled = disabled.contains(option.value);
          return SelectionCard(
            label: option,
            selected: value.contains(option.value),
            onSelected: (val) {
              if (isOptionDisabled) return;
              List<T> selectedListItems = List.of(value);
              selectedListItems.contains(option.value)
                  ? selectedListItems.remove(option.value)
                  : selectedListItems.add(option.value);
              onChanged(selectedListItems);
            },
            avatar: option.avatar,
            selectedIconColor: defaultCardColor,
            unselectedIconColor: selectedCardColor,
            selectedCardColor: selectedCardColor,
            defaultCardColor: defaultCardColor,
            disabledColor: disabledColor,
            shadowColor: shadowColor,
            selectedShadowColor: selectedShadowColor,
            elevation: elevation,
            pressElevation: pressElevation,
            selectedLabelStyle: selectedLabelStyle,
            unselectedLabelStyle: unselectedLabelStyle,
            labelPadding: labelPadding,
            padding:
                padding?.copyWith(left: 15, right: 15, top: 15, bottom: 15),
            selectedShape: selectedShape,
            unselectedShape: unselectedShape,
            expanded: false,
            //infoModalConfig: option.infoModalConfig,
          );
        });
      }).toList(),
    );
  }
}

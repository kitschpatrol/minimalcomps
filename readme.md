<!-- title -->

# MinimalComps

<!-- /title -->

<!-- badges -->

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/license/mit)

<!-- /badges -->

<!-- short-description -->

**Fork of MinimalComps with additional options.**

<!-- /short-description -->

## Overview

[MinimalComps](https://web.archive.org/web/20130719063622/http://www.minimalcomps.com/) is Keith Peters' set of minimal ActionScript 3.0 UI components for Flash.

This fork adds options to several components, a utility that draws components immediately, and an [Adobe Flash Builder](https://web.archive.org/web/20131004040127/http://www.adobe.com/products/flash-builder.html) library project. The [additions table](#additions) below lists the changes.

## Getting started

### Dependencies

An ActionScript 3.0 compiler. The Flash Builder project was updated for the AIR 3.6 SDK in July 2013 and compiles with `-swf-version=21`. The library also compiles with `compc` from AIR SDK 51.4.1.2. AIR is now maintained by Wipro (previously HARMAN), which distributes the current [AIR SDK](https://airsdk.wxlift.com/).

The components embed the PF Ronda Seven font from `src/assets`. `Component.as` has an `[Embed]` line for each compiler. The Flex 4.x SDK line is active. The commented-out lines embed `pf_ronda_seven.swf` for the ASC 2.0 compiler in Flash Builder 4.7, or the TTF file for the Flex 3.x SDK.

### Installation

Add `src` to your project's source path.

Or build a SWC with the AIR SDK's `compc` and add it to your project's library path:

```sh
compc -source-path src -include-sources src -output bin/MinimalComps.swc
```

Or import the repository into Flash Builder as an existing project. It's a library project, so building it produces a SWC in `bin`.

## Usage

```actionscript
package
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.HRangeSlider;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.utils.MinimalUtil;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Example extends Sprite
	{
		public function Example()
		{
			new PushButton(this, 10, 10, "Push", onPush);

			var checkBox:CheckBox = new CheckBox(this, 10, 40, "No shadow");
			checkBox.shadow = false;

			new RadioButton(this, 10, 60, "Red", true, null, "colors");
			new RadioButton(this, 10, 75, "Blue", false, null, "colors");

			var range:HRangeSlider = new HRangeSlider(this, 10, 100, onRangeChange);
			range.allowHandlePush = false;

			MinimalUtil.forceDraw(this);
		}

		private function onPush(event:MouseEvent):void
		{
			trace("Pushed");
		}

		private function onRangeChange(event:Event):void
		{
			var range:HRangeSlider = event.target as HRangeSlider;
			trace(range.lowValue, range.highValue);
		}
	}
}
```

### Additions

| Class            | Change                                                                                                                                                                                     |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `CheckBox`       | `checkBoxWidth` and `checkBoxHeight` set the size of the box. `shadow` turns the drop shadows on or off.                                                                                   |
| `ColorChooser`   | `showInputField` shows or hides the hex input field.                                                                                                                                       |
| `FPSMeter`       | Starts measuring once it's added to the stage, if it wasn't on the stage when it was created.                                                                                              |
| `InputText`      | The text sits 1 px higher.                                                                                                                                                                 |
| `NumericStepper` | `showButtons` shows or hides the plus and minus buttons.                                                                                                                                   |
| `PushButton`     | The default size is 80 × 16 instead of 100 × 20.                                                                                                                                           |
| `RadioButton`    | The constructor takes an optional `groupName` as its last argument.                                                                                                                        |
| `RangeSlider`    | `showCenterHandle` adds a handle between the low and high handles that drags both. `allowHandlePush` lets one handle push the other. Both default to `true` and work in both orientations. |
| `RangeSlider`    | The labels are kept off the display list when `labelMode` is `RangeSlider.NEVER`, so they don't change the component's dimensions.                                                         |
| `Slider`         | `mouseDown` is `true` while the handle is being dragged.                                                                                                                                   |
| `Style`          | `SELECTED` is the fill color of checked check boxes and radio buttons, which used `BUTTON_FACE` before. It defaults to `0xEEEEEE`.                                                         |
| `MinimalUtil`    | `forceDraw(container)` draws every component in a container right away instead of on the next frame.                                                                                       |

## Background

### Implementation notes

This repository's history includes Keith Peters' commits and the pull requests he merged through October 8, 2012. The fork's changes start on October 22, 2012. The source file headers give the MinimalComps version as 0.9.10.

Keith Peters' original repository, `github.com/minimalcomps`, is no longer on GitHub. GitHub lists this repository as a fork of [bclinkinbeard/minimalcomps](https://github.com/bclinkinbeard/minimalcomps), which holds only the first commit.

### Other projects

- [MinimalCompsHX](https://github.com/Beeblerox/MinimalCompsHX) is a Haxe port of MinimalComps.
- [minimalcomps-openfl](https://github.com/jasonsturges/minimalcomps-openfl) is an OpenFL port.

### Known issues

- `CheckBox` keeps its label 12 px from the left and centered on a 10 px box, so the label overlaps a box made larger with `checkBoxWidth` or `checkBoxHeight`.
- Hiding the `NumericStepper` buttons with `showButtons` doesn't widen the value field, which stays 32 px narrower than the component.
- Hiding the `ColorChooser` input field with `showInputField` moves the swatch to the left edge but doesn't change the component's width.
- `Style.setStyle()` doesn't set `Style.SELECTED`, so checked check boxes and radio buttons stay `0xEEEEEE` with `Style.DARK` unless `SELECTED` is set separately.

## Maintainers

[kitschpatrol](https://github.com/kitschpatrol)

## Acknowledgments

MinimalComps was created by [Keith Peters](https://bit-101.com). The history also includes upstream contributions from [ElliotMebane](https://github.com/ElliotMebane), [kommander](https://github.com/kommander), [makc](https://github.com/makc), and [tynril](https://github.com/tynril). The `ColorChooser` popup code is by Rashid Ghassempouri.

<!-- license -->

## License

[MIT](license.txt) © [Eric Mika](https://ericmika.com)

<!-- /license -->

MinimalComps itself is Copyright (c) 2011 Keith Peters, released under the MIT license.

The PF Ronda Seven font files in `src/assets` are Copyright (C) 2007 Yuusuke Kamiyamane and aren't covered by the MIT license. [DaFont](https://www.dafont.com/pf-ronda-seven.font) lists the font as 100% free.

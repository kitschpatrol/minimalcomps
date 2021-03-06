/**
 * CheckBox.as
 * Keith Peters
 * version 0.9.10
 * 
 * A basic CheckBox component.
 * 
 * Copyright (c) 2011 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package com.bit101.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class CheckBox extends Component
	{
		protected var _back:Sprite;
		protected var _button:Sprite;
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _selected:Boolean = false;
		
		private var _shadow:Boolean = true;
		
		private var _checkBoxWidth:Number = 10.0;
		private var _checkBoxHeight:Number = 10.0;
		
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this CheckBox.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label String containing the label for this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function CheckBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, label:String = "", defaultHandler:Function = null)
		{
			_labelText = label;
			_width = 10;
			_height = 10;
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
			mouseChildren = false;
		}
		
		/**
		 * Creates the children for this component
		 */
		override protected function addChildren():void
		{
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			addChild(_back);
			
			_button = new Sprite();
			_button.filters = [getShadow(1)];
			_button.visible = false;
			addChild(_button);
			
			_label = new Label(this, 0, 0, _labelText);
			draw();
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function updateShadow():void {
			if (_shadow) {
				_button.filters = [getShadow(1)];
				_back.filters = [getShadow(2, true)];				
			}
			else {
				_button.filters = null;
				_back.filters = null;	
			}
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_back.graphics.clear();
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawRect(0, 0, _checkBoxWidth, _checkBoxHeight);
			_back.graphics.endFill();
			
			_button.graphics.clear();
			_button.graphics.beginFill(Style.SELECTED);
			_button.graphics.drawRect(_checkBoxWidth* 0.2, _checkBoxHeight * 0.2, _checkBoxWidth* 0.6, _checkBoxHeight * 0.6);
			
			_label.text = _labelText;
			_label.draw();
			_label.x = 12;
			_label.y = (10 - _label.height) / 2;
			_width = _label.width + 12;
			_height = 10;
		}
		
		
		
		
		///////////////////////////////////
		// event handler
		///////////////////////////////////
		
		/**
		 * Internal click handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onClick(event:MouseEvent):void
		{
			_selected = !_selected;
			_button.visible = _selected;
		}
		
		
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the label text shown on this CheckBox.
		 */
		public function set label(str:String):void
		{
			_labelText = str;
			invalidate();
		}
		public function get label():String
		{
			return _labelText;
		}
		
		/**
		 * Sets / gets the selected state of this CheckBox.
		 */
		public function set selected(s:Boolean):void
		{
			_selected = s;
			_button.visible = _selected;
		}
		public function get selected():Boolean
		{
			return _selected;
		}

		/**
		 * Sets/gets whether this component will be enabled or not.
		 */
		public override function set enabled(value:Boolean):void
		{
			super.enabled = value;
			mouseChildren = false;
		}
		
		public function set checkBoxWidth(w:Number):void {
			_checkBoxWidth = w;
			draw();
		}
		
		public function set checkBoxHeight(h:Number):void {
			_checkBoxHeight = h;
			draw();
		}
		
		public function set shadow(value:Boolean):void {
			_shadow = value;
			updateShadow();
		}
		
		public function get shadow():Boolean {
			return _shadow;
		}
		

	}
}
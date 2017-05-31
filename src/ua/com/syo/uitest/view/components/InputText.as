package ua.com.syo.uitest.view.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class InputText extends Component
	{
		protected var _back:Sprite;
		protected var _text:String = "";
		protected var _tf:TextField;
		
		public function InputText(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "", defaultHandler:Function = null)
		{
			this.text = text;
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
		}

		override protected function init():void
		{
			super.init();
			setSize(100, 16);
		}
		
		override protected function addChildren():void
		{
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			addChild(_back);
			
			_tf = new TextField();
			_tf.embedFonts = Style.embedFonts;
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
			_tf.defaultTextFormat = new TextFormat(Style.fontName, Style.fontSize, Style.INPUT_TEXT);
			addChild(_tf);
			_tf.addEventListener(Event.CHANGE, onChange);
			
		}
		
		override public function draw():void
		{
			super.draw();
			_back.graphics.clear();
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();
			
			if(_text != null)
			{
				_tf.text = _text;
			}
			else 
			{
				_tf.text = "";
			}
			_tf.width = _width - 4;
			if(_tf.text == "")
			{
				_tf.text = "X";
				_tf.height = Math.min(_tf.textHeight + 4, _height);
				_tf.text = "";
			}
			else
			{
				_tf.height = Math.min(_tf.textHeight + 4, _height);
			}
			_tf.x = 2;
			_tf.y = Math.round(_height / 2 - _tf.height / 2);
		}
		
		protected function onChange(event:Event):void
		{
			_text = _tf.text;
			event.stopImmediatePropagation();
			dispatchEvent(event);
		}
		
		public function set text(t:String):void
		{
			_text = t;
			if(_text == null) _text = "";
			invalidate();
		}
		public function get text():String
		{
			return _text;
		}
		
		public function get textField():TextField
		{
			return _tf;
		}
		
		public function set restrict(str:String):void
		{
			_tf.restrict = str;
		}
		public function get restrict():String
		{
			return _tf.restrict;
		}
		
		public function set maxChars(max:int):void
		{
			_tf.maxChars = max;
		}
		public function get maxChars():int
		{
			return _tf.maxChars;
		}
		
        public override function set enabled(value:Boolean):void
        {
            super.enabled = value;
            _tf.tabEnabled = value;
        }

	}
}
package core.textures 
{
	import core.codec.BitmapDecoder;
	import core.external.io.DesktopFileLoader;
	import core.external.io.FileChangeChecker;
	import core.IDestructable;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class BitmapFile extends EventDispatcher implements IBitmapOutput, IDestructable
	{
		
		private static var _checkInterval:Timer; 
		
		static public function get checkInterval():Timer 
		{
			if (!_checkInterval)
			{
				_checkInterval = new Timer(100, 0);
				_checkInterval.start();
			}
			
			return _checkInterval;
		}
		
		private var checker:FileChangeChecker = new FileChangeChecker();
		private var loader:DesktopFileLoader = new DesktopFileLoader(true);
		private var bitmapDecoder:BitmapDecoder = new BitmapDecoder();
		
		private var path:String;
		
		private var _output:BitmapData;
		
		public function BitmapFile() 
		{
			initialize();
		}
		
		private function initialize():void 
		{
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			bitmapDecoder.addEventListener(Event.COMPLETE, onDecodeComplete);
			checker.addEventListener(Event.CHANGE, onFileChange);
		}
		
		private function check(e:TimerEvent):void 
		{
			checker.check();
		}
		
		public function init(path:String):void
		{
			this.path = path;
			checker.path = path;
			checker.check();
			
			load();
		}
		
		public function load():void
		{
			loader.load(path);
		}
		
		public function get output():BitmapData 
		{
			return _output;
		}
		
		private function onDecodeComplete(e:Event):void 
		{
			_output = bitmapDecoder.output;
			dispatchEvent(e);
			
			if (!checkInterval.hasEventListener(TimerEvent.TIMER))
				checkInterval.addEventListener(TimerEvent.TIMER, check);
		}
		
		private function onFileChange(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		private function onLoadComplete(e:Event):void 
		{
			bitmapDecoder.decode(loader.data);
		}
		
		public function destroy():void 
		{
			loader.removeEventListener(Event.COMPLETE, onLoadComplete);
			bitmapDecoder.removeEventListener(Event.COMPLETE, onDecodeComplete);
			checker.removeEventListener(Event.CHANGE, onFileChange);
			checkInterval.removeEventListener(TimerEvent.TIMER, check);
			
			_output = null;
		}
		
	}

}
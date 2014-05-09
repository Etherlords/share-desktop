package  core.external.io
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	/**
	 * Dispatched if file was modified
	 * @eventType	flash.events.Event.COMPLETE
	 */
	[Event(name = "complete", type = "flash.events.Event")] 
	
	public class DesktopFileLoader extends FileLoader
	{
		public var async:Boolean = false;

        protected var stream:FileStream = new FileStream();

		public function DesktopFileLoader(isAsync:Boolean = false) 
		{
			async = isAsync;
			
			initialize();
		}
		
		private function initialize():void 
		{
			stream.addEventListener(Event.COMPLETE, onRead);
		}
		
		public override function load(path:String):void
		{
			var file:File = new File(path);
			
			if (!async)
			{
				stream.open(file, FileMode.READ);
				onRead();
			}
			else
				stream.openAsync(file, FileMode.READ);
		}
		
		private function onRead(e:Event = null):void 
		{
			data = new ByteArray();
			stream.readBytes(data, 0, stream.bytesAvailable);
			stream.close();
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}

}
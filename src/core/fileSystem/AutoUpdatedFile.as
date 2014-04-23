package core.fileSystem 
{
	import core.external.io.DesktopFileLoader;
	import core.external.io.FileChangeChecker;
	import flash.events.Event;
	
	/**
	 * Dispatched if file was modified
	 * @eventType	flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")] 
	
	public class AutoUpdatedFile extends FsFile 
	{
		private var fileLoader:DesktopFileLoader = new DesktopFileLoader();
		private var fileChangeScaner:FileChangeChecker = new FileChangeChecker();
		
		public function AutoUpdatedFile() 
		{
			super();
			
			initialize();
		}
		
		private function initialize():void 
		{
			fileChangeScaner.addEventListener(Event.CHANGE, onFileModified)
			fileLoader.addEventListener(Event.COMPLETE, onFileLoadComplete);
		}
		
		private function onFileLoadComplete(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		private function onFileModified(e:Event):void 
		{
			
		}
		
	}

}
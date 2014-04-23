package core.external.io 
{
	import core.INotifer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	/**
	 * Dispatched if file was modified
	 * @eventType	flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")] 
	
	public class FileChangeChecker extends EventDispatcher implements INotifer
	{
		
		private var file:File;
		
		private var _path:String;
		private var date:Number = -1;
		
		private static var updateEvent:Event = new Event(Event.CHANGE);
		
		public function FileChangeChecker() 
		{
			
		}
		
		public function check():void
		{
			var newDate:Number = file.modificationDate.getTime();
			
			var isUpdated:Boolean = newDate != date;
			
			date = newDate;
			
			if (isUpdated)
			{
				dispatchEvent(updateEvent);
			}
		}
		
		public function get path():String 
		{
			return _path;
		}
		
		public function set path(value:String):void 
		{
			_path = value;
			
			if (!file)
				file = new File(path)
			else
				file.resolvePath(path);
		}
		
	}

}
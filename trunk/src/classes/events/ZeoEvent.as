package classes.events
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------
import flash.events.Event;

/**
 *  Zeo Terrace 어플리케이션 내부에서 사용되는 이벤트 클래스
 */
public class ZeoEvent extends Event
{
	//-----------------------------------------------------------------------------
	//
	//  Constants
	//
	//-----------------------------------------------------------------------------
	public static const CREATION_COMPLETE:String = "creationComplete";
	public static const NET_OPEN:String = "netOpen";
	public static const NET_COMPLETE:String = "netComplete";
	//-----------------------------------------------------------------------------
	//
	//  Consturctor
	//
	//-----------------------------------------------------------------------------
	/**
	 *  Constructor.
	 */
	public function ZeoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}

	//-----------------------------------------------------------------------------
	//
	//  Properties
	//
	//-----------------------------------------------------------------------------
	//-----------------------------------------------------------------------------
	//
	//  Override Methods
	//
	//-----------------------------------------------------------------------------
	override public function clone():Event
	{
		return new ZeoEvent(type, bubbles, cancelable);
	}
}
}
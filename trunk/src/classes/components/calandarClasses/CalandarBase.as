package classes.components.calandarClasses
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------
import classes.display.CustomUISprite;

import flash.display.DisplayObject;
import flash.text.TextField;

/**
 *  <p>달력컨포넌트 베이스 클래스</p>
 * 
 *  @author	야훔(igna84@gmail.com)
 *  @since	2010.06.22
 */
public class CalandarBase extends CustomUISprite
{
	//-----------------------------------------------------------------------------
	//
	//  Embeded Images
	//
	//-----------------------------------------------------------------------------
	//-----------------------------------------------------------------------------
	//
	//  Constants
	//
	//-----------------------------------------------------------------------------
	//-----------------------------------------------------------------------------
	//
	//  Consturctor
	//
	//-----------------------------------------------------------------------------
	/**
	 *  Constructor.
	 */
	public function CalandarBase()
	{
		super();
	}
	
	//-----------------------------------------------------------------------------
	//
	//  Variables
	//
	//-----------------------------------------------------------------------------
	protected var dayBlocksArray:Array = [];
	
	private var disabledArrays:Array = [];
	//-----------------------------------------------------------------------------
	//
	//  Override Properties
	//
	//-----------------------------------------------------------------------------
	//-----------------------------------------------------------------------------
	//
	//  Properties
	//
	//-----------------------------------------------------------------------------
	//---------------------------------
	//  weekDayName
	//---------------------------------
	/**
	 *  @private
	 */
	private var _weekDayName:Array = ["일", "월", "화", "수", "목", "금", "토"];
	
	/**
	 *  요일에 표시되는 요일명 처리
	 */
	public function get weekDayName():Array
	{
		return _weekDayName;
	}
	
	/**
	 *  @private
	 */
	public function set weekDayName(value:Array):void
	{
		_weekDayName = value;
	}
	//-----------------------------------------------------------------------------
	//
	//  Override Methods
	//
	//-----------------------------------------------------------------------------

	override protected function createChildren():void
	{
		super.createChildren();
		
		createDateField(-1);
	}
	//-----------------------------------------------------------------------------
	//
	//  Methods
	//
	//-----------------------------------------------------------------------------
	/**
	 *  날짜 필드를 만들어낸다.
	 */
	protected function createDateField(childIndex:int):void
	{
		var columnIndex:int;
		
		for (columnIndex = 0; columnIndex < 7; columnIndex++)
		{
			dayBlocksArray[columnIndex] = [];
			//selectionIndicator[columnIndex] = [];
			
			for (var rowIndex:int = 0; rowIndex < 7; rowIndex++)
			{
				var label:TextField = dayBlocksArray[columnIndex][rowIndex] =	new TextField();
				
				label.selectable = false;
				//label.ignorePadding = true;
				
				if (childIndex == -1)
				{
					addChild(DisplayObject(label));
				}
				else
				{
					addChildAt(DisplayObject(label), childIndex++);
				}
			}
			
			disabledArrays[columnIndex] = new Array(7);
		}
		
		invalidateProperties();
	}
	
	
	//-----------------------------------------------------------------------------
	//
	//  EventHandlers
	//
	//-----------------------------------------------------------------------------
}
}
package classes.display
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------
import classes.core.IResize;
import classes.events.ZeoEvent;
import classes.utils.GraphicUtil;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;

//-----------------------------------------------------------------------------
//
//  Events
//
//-----------------------------------------------------------------------------
[Event(name="creationComplete", type="classes.events.ZeoEvent")]
/**
 *  화면을 만들어 내는데 있어서 기본이되는 Container 객체
 * 
 *  @author	야훔(igna84@gmail.com)
 *  @since	2010.06.22
 */
public class CustomUISprite extends Sprite implements IResize
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
	//  Constructor
	//
	//-----------------------------------------------------------------------------
	/**
	 *  Constructor
	 */
	public function CustomUISprite()
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
	}
	
	//-----------------------------------------------------------------------------
	//
	//  Implements : Properties
	//
	//-----------------------------------------------------------------------------
	/**
	 *  @private
	 */
	private var _autoLayout:Boolean = true;
	
	/**
	 *  사이즈 변경시 레이아웃이나 배경이미지를 재정렬 하기 위한 속성값
	 */
	public function get autoLayout():Boolean
	{
		return _autoLayout;
	}
	
	/**
	 *  @private
	 */
	public function set autoLayout(value:Boolean):void
	{
		_autoLayout = value;
	}
	//-----------------------------------------------------------------------------
	//
	//  Variables
	//
	//-----------------------------------------------------------------------------
	private var isCreateChildren:Boolean = false;
	
	protected var unscaledWidth:Number = 0;
	protected var unscaledHeight:Number = 0;
	//-----------------------------------------------------------------------------
	//
	//  Override Properties
	//
	//-----------------------------------------------------------------------------
	//---------------------------------
	//  Width
	//---------------------------------
	private var _width:Number = 0;

	override public function set width(value:Number):void
	{
		_width = value;
		
		invalidateDisplayList();
	}
	
	private var _height:Number = 0;
	
	override public function set height(value:Number):void
	{
		_height = value;
		
		invalidateDisplayList();
	}
	//-----------------------------------------------------------------------------
	//
	//  Properties
	//
	//-----------------------------------------------------------------------------
	//---------------------------------
	//  defaultWidth
	//---------------------------------
	/**
	 *  @private
	 */
	private var _defaultWidth:Number = 100;
	
	/**
	 *  컨포넌트의 기본 너비
	 */
	protected function get defaultWidth():Number
	{
		return _defaultWidth;
	}
	
	/**
	 *  @private
	 */
	protected function set defaultWidth(value:Number):void
	{
		_defaultWidth = value;
	}
	
	
	//---------------------------------
	//  defaultHeight
	//---------------------------------
	/**
	 *  @private
	 */
	private var _defaultHeight:Number = 100;
	
	/**
	 *  컨포넌트의 기본 높이
	 */
	protected function get defaultHeight():Number
	{
		return _defaultHeight;
	}
	
	/**
	 *  @private
	 */
	protected function set defaultHeight(value:Number):void
	{
		_defaultHeight = value;
	}
	
	//---------------------------------
	//  backgroundAlpha
	//---------------------------------
	/**
	 *  @private
	 */
	private var _backgroundAlpha:Number = 0;
	
	/**
	 *  배경화면(색)의 투명도 값 속성
	 */
	public function get backgroundAlpha():Number
	{
		return _backgroundAlpha;
	}
	
	/**
	 *  @private
	 */
	public function set backgroundAlpha(value:Number):void
	{
		_backgroundAlpha = value;
		
		invalidateDisplayList();
	}

	//---------------------------------
	//  backgroundImage
	//---------------------------------
	/**
	 *  @private
	 */
	private var _backgroundImage:Class;
	
	/**
	 *  배경화면 속성
	 */
	public function get backgroundImage():Class
	{
		return _backgroundImage;
	}
	
	/**
	 *  @private
	 */
	public function set backgroundImage(value:Class):void
	{
		_backgroundImage = value;
		
		invalidateDisplayList();
	}

	//---------------------------------
	//  backgroundColor
	//---------------------------------
	/**
	 *  @private
	 */
	private var _backgroundColor:uint = 0xFF0000;
	
	/**
	 *  배경색
	 */
	public function get backgroundColor():uint
	{
		return _backgroundColor;
	}
	
	/**
	 *  @private
	 */
	public function set backgroundColor(value:uint):void
	{
		_backgroundColor = value;
		
		invalidateDisplayList();
	}

	//---------------------------------
	//  backgroundFullSize
	//---------------------------------
	/**
	 *  @private
	 */
	private var _backgroundImageFullSize:Boolean = true;
	
	/**
	 *  배경색
	 */
	public function get backgroundImageFullSize():Boolean
	{
		return _backgroundImageFullSize;
	}
	
	/**
	 *  @private
	 */
	public function set backgroundImageFullSize(value:Boolean):void
	{
		_backgroundImageFullSize = value;
		
		invalidateDisplayList();
	}
	
	
	//-------------------------------------
	//  borderStyle
	//-------------------------------------
	/**
	 *  @private
	 */
	private var _borderStyle:String = "none";
	
	/**
	 *  외곽선 속성
	 *  
	 *  @default	none
	 */
	public function get borderStyle():String
	{
		return _borderStyle;
	}
	
	[Inspectable(type="String", enumeration="none, solid")]
	/**
	 *  @private
	 */
	public function set borderStyle(value:String):void
	{
		_borderStyle = value;
		
		invalidateDisplayList();
	}
	
	//-------------------------------------
	//  borderWidth
	//-------------------------------------
	/**
	 *  @private
	 */
	private var _borderWidth:Number = 1;
	
	/**
	 *  외곽선 두께 속성
	 *  
	 *  @default	1
	 */
	public function get borderWidth():Number
	{
		return _borderWidth;
	}
	
	/**
	 *  @private
	 */
	public function set borderWidth(value:Number):void
	{
		_borderWidth = value;
		
		invalidateDisplayList();
	}
	
	//-------------------------------------
	//  borderColor
	//-------------------------------------
	/**
	 *  @private
	 */
	private var _borderColor:uint = 1;
	
	/**
	 *  외곽선 색깔
	 *  
	 *  @default	1
	 */
	public function get borderColor():uint
	{
		return _borderColor;
	}
	
	/**
	 *  @private
	 */
	public function set borderColor(value:uint):void
	{
		_borderColor = value;
		
		invalidateDisplayList();
	}
	
	//-------------------------------------
	//  borderAlpha
	//-------------------------------------
	/**
	 *  @private
	 */
	private var _borderAlpha:Number = 1;
	
	/**
	 *  외곽선 투명도
	 *  
	 *  @default	1
	 */
	public function get borderAlpha():Number
	{
		return _borderAlpha;
	}
	
	/**
	 *  @private
	 */
	public function set borderAlpha(value:Number):void
	{
		_borderAlpha = value;
		
		invalidateDisplayList();
	}
	//-----------------------------------------------------------------------------
	//
	//  Override Methods
	//
	//-----------------------------------------------------------------------------
	override public function addChild(child:DisplayObject):DisplayObject
	{
		super.addChild(child);
		
		invalidateDisplayList();
		
		return child;
	}
	//-----------------------------------------------------------------------------
	//
	//  Methods
	//
	//-----------------------------------------------------------------------------
	/**
	 *  화면을 구성하는 자식객체를 생성하는 메서드 
	 */
	protected function createChildren():void
	{
		//
		isCreateChildren = true;
		
		invalidateProperties();
	}
	
	/**
	 *  commitProperties 메서드를 외부에서 실행하기 위한 메서드
	 */
	public function invalidateProperties():void
	{
		commitProperties();
	}
	
	public function invalidateDisplayList():void
	{
		measure();
		
		updateDisplayList(_defaultWidth, _defaultHeight);
	}
	
	/**
	 *  컨포넌트의 기본 사이즈를 지정하는 메서드
	 */
	protected function measure():void
	{
		//
		if(_width > 0 || _height > 0)
		{
			_defaultWidth = _width;
			_defaultHeight = _height;
		}
	}
	
	/**
	 *  컴포넌트의 기본 속성을 지정하는 메서드
	 *  이 메서드를 실행하게 하기 위해서는 invalidateProperties() 메서드를 실행시켜야 한다. 
	 */
	protected function commitProperties():void
	{
		//
		if(isCreateChildren)
		{
			invalidateDisplayList();
		}
	}
	
	/**
	 *  화면을 생성해내고 그려내는 역할을 하는 메서드
	 */
	protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	{
		this.unscaledWidth = unscaledWidth;
		this.unscaledHeight = unscaledHeight;
		
		drawBackground();
		
		if(_borderStyle == "solid")
		{
			drawBorderLine();
		}
		
		if(isCreateChildren)
		{
			isCreateChildren = false;
			dispatchEvent(new ZeoEvent(ZeoEvent.CREATION_COMPLETE, false, false));
		}
	}
	
	/**
	 *  @private
	 * 
	 *  배경을 만들어내는 메서드
	 */
	private function drawBackground():void
	{
		if(unscaledWidth > 0 || unscaledHeight > 0)
		{
			var g:Graphics = this.graphics;
			var gx:Number = 0;
			var gy:Number = 0;
			
			var rw:Number = unscaledWidth;
			var rh:Number = unscaledHeight;
			
			g.clear();
			
			if(_backgroundImage)
			{
				var mat:Matrix = new Matrix();
				var bitmap:BitmapData = GraphicUtil.generateBitmapData(_backgroundImage); 
				
				if(_backgroundImageFullSize)
				{
					if(_autoLayout)
					{
						var rate:Number = 0;
						
						if(unscaledWidth / bitmap.width > unscaledHeight / bitmap.height)
						{
							rate = unscaledWidth / bitmap.width;
						}
						else
						{
							rate = unscaledHeight / bitmap.height;
						}
						
						rw = bitmap.width * rate;
						rh = bitmap.height * rate;
						
						mat.scale(rate, rate);
					}
					else
					{
						mat.scale(unscaledWidth / bitmap.width, unscaledHeight / bitmap.height);
					}
				}
				else
				{
					gx = (unscaledWidth - bitmap.width) / 2;
					gy = (unscaledHeight - bitmap.height) / 2;
					
					mat.translate(gx, gy);
				}
				
				g.beginBitmapFill(bitmap, mat, false, true);
				
				
			}
			else
			{
				g.beginFill(_backgroundColor, _backgroundAlpha);
			}
			
			g.drawRect(0, 0, rw, rh);
			g.endFill();
		}
	}
	
	private function drawBorderLine():void
	{
		var g:Graphics = this.graphics;
		
		g.lineStyle(_borderWidth, _borderColor, _borderAlpha);
		g.drawRect(0, 0, unscaledWidth, unscaledHeight);
	}
	
	//-----------------------------------------------------------------------------
	//
	//  EventHandlers
	//
	//-----------------------------------------------------------------------------
	private function addedToStageHandler(event:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		
		createChildren();
	}
} 
}
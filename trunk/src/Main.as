package
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------
import classes.components.ImageLoader;
import classes.components.calandarClasses.CalandarBase;
import classes.data.ImageAsset;
import classes.display.CustomUISprite;
import classes.events.ZeoEvent;
import classes.utils.ResizeUtil;

import flash.display.Graphics;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

/**
 *  어플리케이션을 구성하는 Main 클래스
 * 
 *  @author	야훔(igna84@gmail.com)
 *  @since	2010.06.22
 */
public class Main extends CustomUISprite
{
	//-----------------------------------------------------------------------------
	//
	//  Embeded Images
	//
	//-----------------------------------------------------------------------------
	[Embed(source="assets/background/bg-1.jpg")]
	private const IMG:Class;
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
	public function Main()
	{
		super();
		
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		addEventListener(ZeoEvent.CREATION_COMPLETE, creationCompleteHandler);
	}
	
	//-----------------------------------------------------------------------------
	//
	//  Variables
	//
	//-----------------------------------------------------------------------------
	private var calandar:CalandarBase;
	
	private var loadingTest:ImageLoader;
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
	//-----------------------------------------------------------------------------
	//
	//  Override Methods
	//
	//-----------------------------------------------------------------------------
	override protected function createChildren():void
	{
		super.createChildren();
		/*
		if(!calandar)
		{
			calandar = new CalandarBase();
			calandar.width = 120;
			calandar.height = 200;
			addChild(calandar);
		}
		*/
	}
	//-----------------------------------------------------------------------------
	//
	//  Methods
	//
	//-----------------------------------------------------------------------------
	//-----------------------------------------------------------------------------
	//
	//  EventHandlers
	//
	//-----------------------------------------------------------------------------
	private function creationCompleteHandler(event:ZeoEvent):void
	{
		stage.addEventListener(Event.RESIZE, resizeHandler);
		this.width = stage.stageWidth;
		this.height = stage.stageHeight;
		
		//this.backgroundImage = IMG;
		this.backgroundImageFullSize = true;
		this.autoLayout = true;
		
		if(!loadingTest)
		{
			loadingTest = new ImageLoader();
			loadingTest.backgroundAlpha = 1;
			loadingTest.backgroundColor = 0xFFFFFF;
			
			addChild(loadingTest);
			
			loadingTest.source = IMG;//"assets/icon/loading.swf";
		}
	}
	
	private function resizeHandler(event:Event):void
	{
		this.width = stage.stageWidth;
		this.height = stage.stageHeight;
	}
} 
}
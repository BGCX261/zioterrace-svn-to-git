package classes.components.playerClasses
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------
import classes.data.ImageAsset;
import classes.display.CustomUISprite;
import classes.events.ZeoEvent;

import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.geom.Matrix;
import flash.net.URLRequest;
import flash.system.LoaderContext;

//-----------------------------------------------------------------------------
//
//  Events
//
//-----------------------------------------------------------------------------
/**
 *  통신을 시작할때 dispatch되는 이벤트
 */
[Event(name="netOpen", type="classes.events.ZeoEvent")]

/**
 *  통신이 완료되면 dispatch되는 이벤트
 */
[Event(name="netComplete", type="classes.events.ZeoEvent")]

/**
 *  통신이 완료되면 dispatch되는 이벤트
 */
[Event(name="progress", type="flash.events.ProgressEvent")]

/**
 *  통신이 시작되고 처리될때 상태를 알리는 이벤트
 */
[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]

/**
 *  통신이 시작되고 처리될때 상태를 알리는 이벤트
 */
[Event(name="ioError", type="flash.events.IOErrorEvent")]


/**
 *  YouTube로 동영상을 로딩하거나 이미지를 로딩하는데 있어서 사용되는 베이스 클래스
 * 
 *  @author	야훔(igna84@gmail.com)
 *  @since	2010.06.22
 */
public class PlayerBase extends CustomUISprite
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
	public function PlayerBase()
	{
		super();
	}
	
	//-----------------------------------------------------------------------------
	//
	//  Variables
	//
	//-----------------------------------------------------------------------------
	private var loading:DisplayObject;
	
	private var loader:Loader;
	
	private var content:DisplayObject;
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
	/**
	 *  @private
	 */
	private var _source:Object;
	
	/**
	 *  <p>로딩할 리소스</p>
	 *  <p>경로를 넣어주거나 임베딩된 Class 데이터형 이미지를 넣어주면 표시한다.</p>
	 */
	public function get source():Object
	{
		return _source;
	}
	
	/**
	 *  @private
	 */
	public function set source(value:Object):void
	{
		_source = value;
		
		if(_source is Class)
		{
			content = new _source();
			
			if(!contains(content))
			{
				addChild(content);
			}
		}
		else if(_source is String)
		{
			var request:URLRequest = new URLRequest(String(_source));
			
			load(request);
		}
		else
		{
			_source = null;
			
			throw(new Error("리소스를 로드할 수 없습니다."));
			
			return;
		}
	}
	
	/**
	 *  @private
	 */
	private var _loadingIcon:Class = ImageAsset.LOADING;

	/**
	 *  @private
	 */
	public function get loadingIcon():Class
	{
		return _loadingIcon;
	}

	/**
	 *  로딩 아이콘
	 */
	public function set loadingIcon(value:Class):void
	{
		_loadingIcon = value;
	}
	
	//-----------------------------------------------------------------------------
	//
	//  Override Methods
	//
	//-----------------------------------------------------------------------------
	/**
	 *  @private
	 */
	override protected function createChildren():void
	{
		super.createChildren();
		
		if(!loader)
		{
			loader = new Loader();
			
			addChild(loader);
		}
	}
	
	override protected function measure():void
	{
		super.measure();
		
		defaultWidth = 400;
		defaultHeight = 300;
	}
	
	
	/**
	 *  @private
	 */
	override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);
		
		if(loader && loader.content)
		{
			content = loader.content;
		}
		
		if(content)
		{
			var matrix:Matrix = new Matrix();
			
			var rate:Number;
			
			var b:Number = borderStyle == "solid" ? borderWidth : 0;
			
			if(content.width >= unscaledWidth)
			{
				rate = unscaledWidth / (content.width + b);
			}
			else
			{
				rate = unscaledHeight / (content.height + b);
			}
			
			matrix.scale(rate, rate);
			matrix.translate((unscaledWidth - (content.width * rate)) / 2, (unscaledHeight - (content.height * rate)) / 2); 
			
			content.transform.matrix = matrix;
		}
	}
	//-----------------------------------------------------------------------------
	//
	//  Methods
	//
	//-----------------------------------------------------------------------------
	/**
	 *  @private
	 */
	protected function load(request:URLRequest, context:LoaderContext=null):void
	{
		configureListeners();
		
		loader.load(request, context);
	}
	
	/**
	 *  @private
	 *  이벤트 등록 메서드
	 */
	private function configureListeners():void
	{
		loader.contentLoaderInfo.addEventListener(Event.OPEN, contentOpenHandler);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentCompleteHandler);
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, contentProgressHandler);
		loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, contentHTTPStatusHandler);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, contentIOErrorHandler);
	}
	
	/**
	 *  @private
	 *  이벤트 삭제 메서드
	 */
	private function removeListeners():void
	{
		loader.contentLoaderInfo.removeEventListener(Event.OPEN, contentOpenHandler);
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, contentCompleteHandler);
		loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, contentProgressHandler);
		loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, contentHTTPStatusHandler);
		loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, contentIOErrorHandler);
	}
	
	//-----------------------------------------------------------------------------
	//
	//  EventHandlers
	//
	//-----------------------------------------------------------------------------
	/**
	 *  @private
	 *  컨텐츠를 로딩할때 통신시작을 알리는 이벤트 핸들러
	 */
	private function contentOpenHandler(event:Event):void
	{
		dispatchEvent(new ZeoEvent(ZeoEvent.NET_OPEN, false, false));
		
		if(!loading)
		{
			loading = new _loadingIcon();
		}
		
		loading.x = (unscaledWidth - loading.width) / 2;
		loading.y = (unscaledHeight - loading.height) / 2;
		
		trace("loading", loading.width, loading.height);
		addChild(loading);
	}
	
	/**
	 *  @private
	 *  컨텐츠를 로딩할때 통신완료를 알리는 이벤트 핸들러
	 */
	private function contentCompleteHandler(event:Event):void
	{
		dispatchEvent(new ZeoEvent(ZeoEvent.NET_COMPLETE, false, false));
		
		removeListeners();
		
		invalidateDisplayList();
		
		removeChild(loading);
	}
	
	/**
	 *  @private
	 *  컨텐츠 로딩 중
	 */
	private function contentProgressHandler(event:ProgressEvent):void
	{
		dispatchEvent(event);
	}
	
	/**
	 *  @private
	 *  컨텐츠 로딩 상태
	 */
	private function contentHTTPStatusHandler(event:HTTPStatusEvent):void
	{
		dispatchEvent(event);
	}
	
	/**
	 *  @private
	 *  컨텐츠 IOError 이벤트
	 */
	private function contentIOErrorHandler(event:IOErrorEvent):void
	{
		dispatchEvent(event);
		
		removeListeners();
		removeChild(loading);
	}
}
}
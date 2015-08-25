package classes.net
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------
import classes.core.IDestroy;
import classes.events.XMLLoaderEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;
import flash.net.URLStream;
//-----------------------------------------------------------------------------
//
//  Events
//
//-----------------------------------------------------------------------------
/**
 *  XMLLoader클래스에서 데이터를 Load하고 다 받았을 때 발생하는 이벤트
 */
[Event(name="dataReceived", type="classes.events.XMLLoaderEvent")]

/**
 *  XMLLoader클래스에서 데이터를 Load하는 중에 발생하는 이벤트
 */
[Event(name="dataLoadProgress", type="classes.events.XMLLoaderEvent")]

/**
 *  XMLLoader클래스에서 데이터를 Load하기 위해 커넥션을 열었을 때 발생하는 이벤트
 */
[Event(name="dataLoadOpen", type="classes.events.XMLLoaderEvent")]

/**
 *  XMLLoader클래스에서 IOError가 발생할 때 이벤트
 */
[Event(name="dataIOError", type="classes.events.XMLLoaderEvent")]

/**
 *  XML을 로드하기 위한 통신 클래스. 서버 인코딩에 상관없이 Adobe Flex가 지원할 수 있는 모든 문자열에 대응해 데이터를 인코딩한다.
 * 
 *  @author         전종호(igna84@gmail.com)
 *  @since          2010.02.08
 */
public class XMLLoader extends EventDispatcher implements IDestroy
{
    //-----------------------------------------------------------------------------
    //
    //  Constructor
    //
    //-----------------------------------------------------------------------------
    /**
     *  Constructor.
     */
    public function XMLLoader():void
    {
        super();
    }
    //-----------------------------------------------------------------------------
    //
    //  Variables
    //
    //-----------------------------------------------------------------------------
    /**
     *  @private
     */
    private var urlStream:URLStream;

    /**
     *  @private
     *  인코딩 문자열 저장
     */
    private var encode:String = "utf-8";
    //-----------------------------------------------------------------------------
    //
    //  Properties
    //
    //-----------------------------------------------------------------------------
    //-----------------------------------------------------------------------------
    //
    //  override Methods
    //
    //-----------------------------------------------------------------------------
    //-----------------------------------------------------------------------------
    //
    //  Methods
    //
    //-----------------------------------------------------------------------------
    /**
     *  @private
     *  load
     *  
     *  @param  request 로드할 데이터의 원격 주소 request
     *  @param  encode  로드한 데이터를 어떤 문자열로 인코딩 할지 지정하는 파라미터.
     *  @default utf-8
     */
    public function load(request:URLRequest, encode:String = "utf-8"):void
    {
        if(!urlStream)
        {
            urlStream = new URLStream()
        }

        this.encode = encode;
        
        urlStream.addEventListener(Event.OPEN, streaOpenHandler);
        urlStream.addEventListener(ProgressEvent.PROGRESS, streamProgressHandler);
        urlStream.addEventListener(Event.COMPLETE, streamCompleteHanlder);
        urlStream.addEventListener(IOErrorEvent.IO_ERROR, streamIOErrorHandler);
        urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, streamSecurityErrorHandler);

        urlStream.load(request);
    }

    /**
     *  XMLLoader 클래스 내부에 선언된 객체들의 일괄적 삭제 및 이벤트 삭제
     */
    public function destroy():void
    {
        urlStream.removeEventListener(Event.OPEN, streaOpenHandler);
        urlStream.removeEventListener(ProgressEvent.PROGRESS, streamProgressHandler);
        urlStream.removeEventListener(Event.COMPLETE, streamCompleteHanlder);
        urlStream.removeEventListener(IOErrorEvent.IO_ERROR, streamIOErrorHandler);
        urlStream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, streamSecurityErrorHandler);

        urlStream.close();
        
        urlStream = null;
    }

    //-----------------------------------------------------------------------------
    //
    //  EventHandlers
    //
    //-----------------------------------------------------------------------------
    /**
     *  @private
     *  데이터에 접근하여 열었을 때
     */
    private function streaOpenHandler(event:Event):void
    {
        dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.DATA_LOAD_OPEN));
    }

    /**
     *  @private
     *  데이터를 받아올때
     */
    private function streamProgressHandler(event:ProgressEvent):void
    {
        dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.DATA_LOAD_PROGRESS, false, false, null, event.bytesLoaded, event.bytesTotal));
    }

    /**
     *  @private
     *  streamCompleteHandler
     *  데이터로드가 다 완료했을 때
     */
    private function streamCompleteHanlder(event:Event):void
    {   
        var str:String = urlStream.readMultiByte(urlStream.bytesAvailable, encode);
        if(str.indexOf("<?") != -1)
		{
			str = str.substring(str.indexOf("?>") + 2, str.length);
		}
        
        while(str.indexOf("\r") != -1)
        {
            str = str.replace("\r", " ");
        }
        
        while(str.indexOf("\n") != -1)
        {
            str = str.replace("\n", " ");
        }
        try
        {
            var xml:XML = new XML(str);
            dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.DATA_RECEIVED, false, false, xml, 0, 0));
        }
        catch(e:Error)
        {
            dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.DATA_RECEIVED, false, false, str, 0, 0));
        }

        destroy();
    }

    /**
     *  @private
     *  streamIOErrorHandler
     *  IOError 발생시
     */
    private function streamIOErrorHandler(event:IOErrorEvent):void
    {
        dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.DATA_IO_ERROR, false, false, null, 0, 0, event.text));

        destroy();
    }

    /**
     *  @private
     *  streamSecurityErrorHandler
     *  보안에러 발생시
     */
    private function streamSecurityErrorHandler(event:SecurityErrorEvent):void
    {
        trace("security error");

        destroy();
    }
}
}
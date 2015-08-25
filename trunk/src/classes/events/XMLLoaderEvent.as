/**
 *  @author         전종호(igna84@gmail.com)
 *  @since          2010.02.08
 *  @version		Flex SDK 3.5.0 build 12683
 *  @description    XMLLoader 클래스에서 발생하는 이벤트 객체.
 */
package classes.events
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------
import flash.events.Event;

/**
 * XMLLoader 클래스에서 발생하는 이벤트 객체로
 * 전송과정중의 로드된 데이터 양이나 데이터 총 양, 전송완료, IOError 같은 문제가 발생했을때나 커넥션을 열었을때 발생한다.
 */
public class XMLLoaderEvent extends Event
{
    //-----------------------------------------------------------------------------
    //
    //  Constants
    //
    //-----------------------------------------------------------------------------
    /**
     *  데이터 로드가 진행중일 때 발생하는 이벤트 상수
     */
    public static const DATA_LOAD_PROGRESS:String = "dataLoadProgress";
    
    /**
     *  데이터 로드가 완료 되었을때 발생하는 이벤트 상수
     */
    public static const DATA_RECEIVED:String = "dataReceived";
    
    /**
     *  데이터를 로드하는데 IOError가 발생할때 이벤트 상수
     */
    public static const DATA_IO_ERROR:String = "dataIOError";
    
    /**
     *  데이터를 로드하기 위해 커넥션을 열었을 때 발생하는 이벤트 상수
     */
    public static const DATA_LOAD_OPEN:String = "dataLoadOpen";

    //-----------------------------------------------------------------------------
    //
    //  Constructor
    //
    //-----------------------------------------------------------------------------

    /**
     *  Constructor.
     */
    public function XMLLoaderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
                                   data:Object = null, loadedBytes:Number = 0, totalBytes:Number = 0, message:String = ""):void
    {
        super(type, bubbles, cancelable);

        this.data = data;

        this.loadedBytes = loadedBytes;

        this.totalBytes = totalBytes;
    }

    /**
     *  data
     *  XMLLoader를 통해 전달받은 데이터
     */
    public var data:Object = null;

    /**
     *  전송받은 용량
     */
    public var loadedBytes:Number = 0;

    /**
     *  전송받는 데이터 총량
     */
    public var totalBytes:Number = 0;
    
    /**
     *  IOError가 발생했을때 에러 메시지
     */
    public var message:String = "";

    //-----------------------------------------------------------------------------
    //
    //  Override Methods
    //
    //-----------------------------------------------------------------------------
    /**
     *  clone
     *  @return Event
     */
    override public function clone():Event
    {
        return new XMLLoaderEvent(type, bubbles, cancelable, data, loadedBytes, totalBytes);
    }
}
}
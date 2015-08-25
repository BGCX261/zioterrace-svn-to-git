package classes.components.mapClasses
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------
import com.google.maps.LatLng;
import com.google.maps.PaneId;
import com.google.maps.interfaces.IMarker;
import com.google.maps.interfaces.IPane;
import com.google.maps.overlays.OverlayBase;

import flash.display.DisplayObject;

/**
 *  <p>맵 내부에 표시되는 마커 클래스</p>
 * 
 *  @author	야훔(igna84@gmail.com)
 *  @since	2010.06.22
 */
public class Marker extends OverlayBase implements IMarker
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
	public function Marker(latLon:LatLng, comp:DisplayObject)
	{
		super();
		
		_latLon = latLon;
		_comp = comp;
		
		addEventListener(MapEvent.OVERLAY_ADDED,handleMapEvent,false,0,true);
		addEventListener(MapEvent.OVERLAY_REMOVED,handleMapEvent,false,0,true);
		addEventListener(MouseEvent.CLICK,handleMapEvent,false,0,true);
	}
	
	//-----------------------------------------------------------------------------
	//
	//  Implements : Properties
	//
	//-----------------------------------------------------------------------------
	//-----------------------------------------------------------------------------
	//
	//  Implements : Methods
	//
	//-----------------------------------------------------------------------------
	/**
	 *  Opens an information window above the marker.
	 * 
	 *  @param	options:InfoWindowOptions InfoWindow options.  
	 *  @param	useSeparatePane:Boolean If true, the information window will be placed on its own pane. When using Map3D,
	 *  the default behavior is to place the information window on the same pane as this marker,
	 *  so that it may be positioned at the same depth.
	 *  Set this parameter true to force the behavior to be the same as when using a 2-D map (information windows are placed on their own pane).  
	 */
	public function openInfoWindow(opts:InfoWindowOptions=null, useSeparatePane:Boolean):IInfoWindow
	{
		return pane.map.openInfoWindow(_latLon,opts);
	}
	
	// not using MarkerOptions
	/**
	 *  Updates the marker options.
	 *  The options parameter may specify a complete or partial set of marker options.
	 *  If a partial set of options is specified, it will supplement the existing marker options,
	 *  overriding only the values that were set explicitly and leaving the rest unchanged. 
	 */
	public function setOptions(arg0:MarkerOptions):void
	{
	}
	
	/**
	 *  Retrieves the full set of options used by the marker. Use the setOptions method to modify the options on the marker. 
	 */
	public function getOptions():MarkerOptions
	{
		return null;
	}
	
	/**
	 *  Closes the info window if it is associated with this marker.
	 */
	public function closeInfoWindow():void
	{
		pane.map.closeInfoWindow();
	}
	
	/**
	 *  Retrieves the location of the marker.
	 *  
	 * 	@return LatLng	LatLng of the marker.  
	 */
	public function getLatLng():LatLng
	{
		return _latLon;
	}
	
	/**
	 *  Changes the LatLng of the marker.
	 * 
	 * 	@param	latLon	New LatLng location of the marker. 
	 */
	public function setLatLng(latLon:LatLng):void
	{
		_latLon = latLon;
	}
	
	/**
	 *  Reposition the overlay on the screen.
	 *  This method is called in response to changes in the position (centre) of the map and/or the map's zoom level.
	 *  Developers should not call the method themselves.
	 *  The implementation of this method should either change the position of the overlay
	 *  on the screen in response to the change of the map's centre or redraw the overlay completely
	 *  if it needs to be reconfigured for a different map centre/zoom level.
	 *  Repositioning of the overlay should be done by changing the placement of the overlay's display object
	 *  on its pane using the mappings provided by the IPane interface (fromLatLngToPaneCoords or fromProjectionPointToPaneCoords).
	 * 
	 *  @param	zoom	Whether the zoom level of the map has changed or the call was invoked just as a result of a map pan.  
	 */
	override public function positionOverlay(zoom:Boolean):void
	{
		var p:Point = pane.fromLatLngToPaneCoords(_latLon,true);
		_comp.x = p.x - _comp.width/2;
		_comp.y = p.y - _comp.height/2;
	}
	
	/**
	 *  Retrieves the default pane that this overlay should be placed on if none is explicitly specified
	 *  (when the overlay is added through the IMap.addOverlay() call).
	 * 
	 *  @param	map		Instance of map that this overlay is added to.
	 *  @return	IPane	Instance of IPane to which the overlay will be added by default.  
	 */
	override public function getDefaultPane(map:IMap):IPane
	{
		return map.getPaneManager().getPaneById(PaneId.PANE_MARKER);
	}
	//-----------------------------------------------------------------------------
	//
	//  Variables
	//
	//-----------------------------------------------------------------------------
	private var _latLon:LatLng;
	private var _comp:UIComponent;
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
	//-----------------------------------------------------------------------------
	//
	//  Methods
	//
	//-----------------------------------------------------------------------------
	/**
	 * 
	 */
	public function isHidden():Boolean
	{
		return false;
	}
	
	public function hide():void
	{
	}
	
	public function show():void
	{
	}
	
	//-----------------------------------------------------------------------------
	//
	//  EventHandlers
	//
	//-----------------------------------------------------------------------------
	private function handleMapEvent(event:Event):void
	{
		switch(event.type)
		{
			case MouseEvent.CLICK:
				openInfoWindow( new InfoWindowOptions(
					{ content: "This is a Google Maps InfoWindow." } ) );
				break;
			
			case MapEvent.OVERLAY_ADDED:
				addChild(_comp);
				break;
			
			case MapEvent.OVERLAY_REMOVED:
				removeChild(_comp);
				break;
		}
	}
}
}
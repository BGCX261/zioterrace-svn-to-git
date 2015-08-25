package com.sunild.markers
{
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.PaneId;
	import com.google.maps.interfaces.IInfoWindow;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.interfaces.IMarker;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.OverlayBase;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.UIComponent;

	public class DMarker extends OverlayBase implements IMarker
	{
		private var _latLon:LatLng;
		private var _comp:UIComponent;
		
		public function DMarker(latLon:LatLng, comp:UIComponent)
		{
			super();
			_latLon = latLon;
			_comp = comp;
			
			addEventListener(MapEvent.OVERLAY_ADDED,handleMapEvent,false,0,true);
			addEventListener(MapEvent.OVERLAY_REMOVED,handleMapEvent,false,0,true);
			addEventListener(MouseEvent.CLICK,handleMapEvent,false,0,true);
		}
		
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
		
		public function openInfoWindow(opts:InfoWindowOptions=null):IInfoWindow
		{
			return pane.map.openInfoWindow(_latLon,opts);
		}
		
		public function closeInfoWindow():void
		{
			pane.map.closeInfoWindow();
		}
		
		// not using MarkerOptions
		public function setOptions(arg0:MarkerOptions):void
		{
		}
		
		public function getOptions():MarkerOptions
		{
			return null;
		}
		
		public function getLatLng():LatLng
		{
			return _latLon;
		}
		
		public function setLatLng(latLon:LatLng):void
		{
			_latLon = latLon;
		}
		
		override public function positionOverlay(zoom:Boolean):void
		{
			var p:Point = pane.fromLatLngToPaneCoords(_latLon,true);
			_comp.x = p.x - _comp.width/2;
			_comp.y = p.y - _comp.height/2;
		}
		
		override public function getDefaultPane(map:IMap):IPane
		{
			return map.getPaneManager().getPaneById(PaneId.PANE_MARKER);
		}
		
		
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
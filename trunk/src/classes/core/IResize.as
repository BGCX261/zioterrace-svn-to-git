package classes.core
{
//-----------------------------------------------------------------------------
//
//  Imports
//
//-----------------------------------------------------------------------------

/**
 *  Resize관련된 인터페이스 클래스로 기본적으로 CustomUISprite 클래스에서 구현되게 한다.
 * 
 *  @author	야훔(igna84@gmail.com)
 *  @since	2010.06.22
 */
public interface IResize
{
	/**
	 *  사이즈 변경시 레이아웃이나 배경이미지를 재정렬 하기 위한 속성값
	 */
	function set autoLayout(value:Boolean):void;
	
	/**
	 *  @private
	 */
	function get autoLayout():Boolean;
}
}
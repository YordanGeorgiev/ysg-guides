// file: scala-cheat-sheet.scala

// how-to assign var in foreach loop
  val objFileHandler = new FileHandler ()
  objFileHandler.getFileTree( new File ( dataCsvDir ) )
    .filter(_.getName.endsWith(".csv"))
		  .foreach{
          x => var f = x;
          /* some operation */
	       println
}

// how-to declare hc array
val a = Array("apple", "banana", "orange")
val newArray = for (e <- a) yield e.toUpperCase

// how-to create immutable maps 
val mapStates = Map("AL" -> "Alabama", "AK" -> "Alaska")
// how-to create a mutable map
var mapStates = collection.mutable.Map("AL" -> "Alabama")
var mapStates = collection.mutable.Map[String, String]()
mapStates += ("AL" -> "Alabama")

val objList :List[Int] = List(1,2,3)

// START how-to use Option , None , Some in Scala
toInt(someString) match {
    case Some(i) 	=> println(i)
    case None 		=> println("That didn't work.")
}
// STOP how-to use Option , None , Some in Scala

or even better use the Either idiom

// START how-to use Either
  divideXByY(1, 0) match {
      case Left(s) => println("Answer: " + s)
      case Right(i) => println("Answer: " + i)
  }

  /**
   * A simple method to demonstrate how to declare that a method returns an Either,
   * and code that returns a Left or Right.
   */
  def divideXByY(x: Int, y: Int): Either[String, Int] = {
      if (y == 0) 
      	Left("Dude, can't divide by 0")
      else 
      	Right(x / y)
  }

// STOP how-to use Either




Command + Alt + left arrow - go back in code
Command + Alt + right arrow - go forth in code
Command + Alt + Shift + L - format code in the current file  , cursor has to be there
Command + Alt + T - fold selected text 
Command + R - search and replace 
Command + F - search in code , use the arrows to jump to the next or the previous ... , Esc to escape the search mode


// eof file: scala-cheat-sheet.scala
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

// eof file: scala-cheat-sheet.scala

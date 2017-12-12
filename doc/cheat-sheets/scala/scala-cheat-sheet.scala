// file: scala-cheat-sheet.scala

// how-to assign var in foreach loop
  val objFileHandler = new FileHandler ()
  objFileHandler.getFileTree( new File ( dataCsvDir ) )
    .filter(_.getName.endsWith(".csv"))
		  .foreach{
          x => {
            var f = x;
	         println ( f.toString() )
            /* some operation */
          }
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

  val lstInts :List[Int] = List(1,2,3)

// START how-to use Option , None , Some in Scala
  toInt(someString) match {
      case Some(i) 	=> println(i)
      case None 		=> println("That didn't work.")
  }
// STOP how-to use Option , None , Some in Scala

// or even better use the Either idiom

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


// create hc dataframe
  var input1 = spark.createDataFrame(Seq(
  (10L, "Joe Doe", 34),
  (11L, "Jane Doe", 31),
  (12L, "Alice Jones", 25)
  )).toDF("id", "name", "age")
// stop create hs dataframe

//start how-to use case objects instead of Enumerations
    sealed trait FakeEnumeration { def key: String; def value: String }

    case object fakeEnumKey1 extends FakeEnumeration {
      val key = "key-01"; val value = "value-01"
    }
    case object fakeEnumKey2 extends FakeEnumeration {
      val key = "key-01"; val value = "value-02"
    }
// stop 

// START foldLeft usage 
val outDf: DataFrame = lstColumnsToIterate
      .foldLeft(inDf)((tmpDf, iterableColToAdd) => {
        tmpDf.withColumn(iterableColToAdd,expr(funcToApply).as(iterableColToAdd))
      })
      .groupBy(lstGroupByCols.distinct.head, lstGroupByCols.distinct.tail: _*)
      .agg(lstAggregationCols.distinct.head, lstAggregationCols.distinct.tail: _*)
// STOP foldLeft usage


// eof file: scala-cheat-sheet.scala
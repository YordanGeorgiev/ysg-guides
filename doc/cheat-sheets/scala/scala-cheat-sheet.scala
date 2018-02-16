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



// START CREATE HARDCODED DF 
    val spark = SparkSession.builder().getOrCreate()
    import spark.implicits._

    val df = spark.createDataFrame(
      Seq(
      (1, None,    null.asInstanceOf[Integer], "F"),
      (2, Some(2), 4, "F"),
      (3, Some(3), 6, "N"),
      (4, None,    8, "F")
    )).toDF("A", "B", "C","D")

    df.show
    println ( df.schema.mkString(" , "))
// STOP  CREATE HARDCODED DF 


    // START how-to populate data - OBS NOT VERIFIED

    val spark = SparkSession.builder().getOrCreate()
    val sc = spark.sparkContext
    val sqlContext = spark.sqlContext

    import spark.implicits._
    import sqlContext.implicits._

    case class CaseClazz(
                       id:Integer,
                       foobar:String,
    )


    /**
      * Build and return a schema to use for the sample manual data
      */
package com.nokia.ava.npo.musa.measurements

import org.apache.spark.sql.{DataFrame, Row, SparkSession}
import org.scalatest.FunSuite
import com.nokia.ava.npo.musa.CassandraTestContext
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.types._

class TestDataPOC extends FunSuite with CassandraTestContext {

  val KEYSPACE = "notused"

  /**
    * A POC for creating testing data via
    */
  test("test populatoion of data from case class ") {

    // START how-to populate data
    val spark = SparkSession.builder().getOrCreate()
    val sc = spark.sparkContext
    val sqlContext = spark.sqlContext

    import spark.implicits._
    import sqlContext.implicits._

    case class CaseClazz(
                          id:Integer,
                          foobar:String
                        )

    // obs first and second row hardcoded vals are for "teaching" schema !!!
    val rddInServers = sc.parallelize(
      List [CaseClazz](
        // the first row should stay the same as all the freqs are different
        CaseClazz(1,"foo"),
        // the 2nd should stay the same as all the frequencies are different
        CaseClazz(2,"bar") //,

      ))

    val rddInManual: RDD[Row] = rddInServers.map( (c: CaseClazz) => Row(
      c.id,
      c.foobar
    ))

    val schema = buildSchema
    val dfIn :DataFrame = sqlContext.createDataFrame( rddInManual, schema)

    println (dfIn.show)
    // STOP  how-to populate data with case classes


    // assert(dfOut.collect().toSeq.toSet == dfToCmp.collect().toSeq.toSet)
    true
  }


  /**
    * Build and return a schema to use for the sample manual data
    */
  def buildSchema() : StructType = {
    val schema = StructType (
      Seq (
        StructField("id", IntegerType, false),
        StructField("foobar", StringType, false)
      )
    )
    schema
  }

}
      // STOP  how-to populate data with case classes


// START how-to implement command pattern with scala and implicits
object WKTColumnsAdditionStage {
  def read(fileType: MeasurementFileType, filePath: String): DataFrame = ???
}

object implicits {

  implicit class FilteringStage(df: DataFrame) {
    def filter: DataFrame = ???
  }

}

class Reader(configuration: MusaParameters) {

  import implicits._

  def read(fileType: MeasurementFileType, filePath: String): DataFrame = {
    WKTColumnsAdditionStage
      .read(fileType, filePath)
      .filter
  }
}

// START how-to implement command pattern with scala and implicits


// start how-to writer dummy logger
  val now = Calendar.getInstance().getTime()
  var logWriter = new BufferedWriter(new FileWriter(logFile, true))
  val logStringStart = "Start: " + filePath + ", " + now
  logWriter.write(logStringStart)
  println(logStringStart) 
// stop how-to write dummy logger 


// start how-to read dataframe schema from json file 
 def schema = DataType.fromJson(schemaJson).asInstanceOf[StructType]

  def schemaJson =
    Source
      .fromInputStream(
        getClass.getResourceAsStream("/schemas/input/4GConnected.json"))
      .mkString

{
  "type" : "struct",
  "fields" : [ {
    "name" : "moClass",
    "type" : "string",
    "nullable" : false,
    "metadata" : { }
  },{ 
    "name" : "itemLists",
    "type" : {
      "type" : "map",
      "keyType" : "string",
      "valueType" : {
        "type" : "array",
        "elementType" : {
          "type" : "map",
          "keyType" : "string",
          "valueType" : "string",
          "valueContainsNull" : true
        },
        "containsNull" : true
      },
      "valueContainsNull" : true
    },
    "nullable" : true,
    "metadata" : { }
  } ]
} 


// stop 


// src - scala dependency injection 
http://di-in-scala.github.io/#manual
// 





// eof file: scala-cheat-sheet.scala

using System;
using System.IO;
using SharpFuzz;

namespace Jil.Fuzz
{
  public class Program
  {
    public static void Main(string[] args)
    {
      //Fuzzer.LibFuzzer.Run(stream =>
      Fuzzer.OutOfProcess.Run(stream =>
      {
        try
        {
          /* For LibFuzzer.
          string str = ""; 
          for (int i = 0; i < stream.Length; i++)
          {
            str += (char)stream[i];
          }
          JSON.DeserializeDynamic(str);*/

          using (var reader = new StreamReader(str))
          {
            JSON.DeserializeDynamic(reader);
          }
        }
        catch (DeserializationException) { }
      });
    }
  }
}

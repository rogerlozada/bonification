using Microsoft.VisualStudio.TestTools.UnitTesting;
using  BonificationErp.Application;

namespace BonificationErp.Tests
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            Assert.IsTrue(Operacoes.somar(2,2) == 4);
        }

        [TestMethod]
        public void TestMethod2()
        {
            Assert.IsTrue(Operacoes.substrair(2,2) == 0);
        }
    }
}

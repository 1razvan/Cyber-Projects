import unittest
import sqlselectemployee


class Test_sqlselectproduct(unittest.TestCase):

   
    def test_addnum(self):
        self.assertTrue(sqlselectproduct.addnum(1,2) == 3)
        

if __name__ == '__main__':
    unittest.main()


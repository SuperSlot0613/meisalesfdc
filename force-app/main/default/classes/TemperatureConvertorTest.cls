@isTest
public class TemperatureConvertorTest {
    @isTest static void testWrampTemp(){
        Decimal dc=TemperatureConvertor.FahrenheitToCelsius(70);
        System.assertEquals(21.11,dc);
    }
    
    @isTest static void testFreezingPoint(){
        Decimal dc=TemperatureConvertor.FahrenheitToCelsius(32);
        System.assertEquals(0,dc);
    }
    
    @isTest static void testBoilingPoint(){
        Decimal dc=TemperatureConvertor.FahrenheitToCelsius(212);
        System.assertEquals(100,dc,'Boiling Point is not Expected');
    }
    
    @isTest static void testNegativeTemp(){
        Decimal dc=TemperatureConvertor.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33,dc,'Negative Temp is not Expected');
    }
}
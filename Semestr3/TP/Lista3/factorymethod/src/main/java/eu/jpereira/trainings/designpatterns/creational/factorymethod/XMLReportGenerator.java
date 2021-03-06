package eu.jpereira.trainings.designpatterns.creational.factorymethod;

public class XMLReportGenerator extends ReportGenerator {


    @Override
    public Report instantiateReport() {
        return new XMLReport();
    }
}

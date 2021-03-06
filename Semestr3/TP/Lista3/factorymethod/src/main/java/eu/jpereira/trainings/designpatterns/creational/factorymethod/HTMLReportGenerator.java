package eu.jpereira.trainings.designpatterns.creational.factorymethod;

public class HTMLReportGenerator extends ReportGenerator {
    @Override
    public Report instantiateReport() {
        return new  HTMLReport();
    }
}

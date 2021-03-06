package eu.jpereira.trainings.designpatterns.creational.factorymethod;

public class JSONReportGenerator extends  ReportGenerator{

    @Override
    public Report instantiateReport() {
        return new JSONReport();
    }
}

package eu.jpereira.trainings.designpatterns.creational.factorymethod;

public class PDFReportGenerator extends ReportGenerator {

    @Override
    public Report instantiateReport() {
        return new PDFReport();
    }
}

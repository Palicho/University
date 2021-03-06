package eu.jpereira.trainings.designpatterns.creational.abstractfactory;

public interface AbstractReportElementsFactory {
    public ReportBody createReportBody();
    public ReportFooter createReportFooter();
    public ReportHeader createReportHeader();
}

package eu.jpereira.trainings.designpatterns.creational.builder.model;

public interface ReportBodyBuilder {
    void setSaleEntry(SaleEntry saleEntry);
    ReportBody getReportBody();
}
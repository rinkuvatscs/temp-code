package com.telemune.webadmin.webif;

import java.awt.Color;
import java.awt.GradientPaint;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.chart.labels.StandardCategoryLabelGenerator;
import org.jfree.chart.labels.ItemLabelPosition;
 import org.apache.log4j.*;
public class AdminChartBean
{
    private static Logger logger=Logger.getLogger(AdminChartBean.class);
    private String title = "Bar Chart";
    private String xAxisTitle = "Category";
    private String yAxisTitle = "Values";
    private org.jfree.chart.JFreeChart jFreeChart = null;
    private CategoryDataset categoryDataset = new org.jfree.data.category.DefaultCategoryDataset ();
    
    AdminChartBean (String title, String xAxisTitle, String yAxisTitle)
    {
        this.title = title;
        this.xAxisTitle = xAxisTitle;
        this.yAxisTitle = yAxisTitle;
    }
    
    public String getTitle ()
    {
        return title;
    }
    public void setTitle (String title)
    {
        this.title = title;
    }
    
    public String getXAxisTitle ()
    {
        return xAxisTitle;
    }
    public void setXAxisTitle (String xAxisTitle)
    {
        this.xAxisTitle = xAxisTitle;
    }
    
    public String getYAxisTitle ()
    {
        return yAxisTitle;
    }
    public void setYAxisTitle (String yAxisTitle)
    {
        this.yAxisTitle = yAxisTitle;
    }
    
    public CategoryDataset getCategoryDataset ()
    {
        return categoryDataset;
    }
    
    public void setCategoryDataset (CategoryDataset categoryDataset)
    {
        this.categoryDataset = categoryDataset;
    }
    
    static class LabelGenerator extends org.jfree.chart.labels.StandardCategoryLabelGenerator
    {

        public java.lang.String generateItemLabel(org.jfree.data.category.CategoryDataset categorydataset, int i, int j)
        {
            return categorydataset.getRowKey(i).toString();
        }

        LabelGenerator()
        { }
    }
    
    public static org.jfree.chart.JFreeChart getChart (String title, String xAxisTitle, String yAxisTitle, CategoryDataset categoryDataset)
    {
					logger.debug("in getChart() "+title);	
        JFreeChart jfreechart = org.jfree.chart.ChartFactory.createBarChart (title, xAxisTitle, yAxisTitle, categoryDataset, org.jfree.chart.plot.PlotOrientation.VERTICAL, true, true, false);
					logger.debug("in getChart() "+title);	
        jfreechart.setBackgroundPaint (java.awt.Color.white);
        org.jfree.chart.plot.CategoryPlot categoryplot = jfreechart.getCategoryPlot ();
        categoryplot.setBackgroundPaint (java.awt.Color.lightGray);
        categoryplot.setDomainGridlinePaint (java.awt.Color.white);
        categoryplot.setDomainGridlinesVisible (true);
        categoryplot.setRangeGridlinePaint (java.awt.Color.white);
        org.jfree.chart.axis.NumberAxis numberaxis = (org.jfree.chart.axis.NumberAxis)categoryplot.getRangeAxis ();
        numberaxis.setStandardTickUnits (org.jfree.chart.axis.NumberAxis.createIntegerTickUnits ());
        org.jfree.chart.renderer.category.BarRenderer barrenderer = (org.jfree.chart.renderer.category.BarRenderer)categoryplot.getRenderer ();
//	barrenderer.setDrawBarOutline(true);
  	barrenderer.setDrawBarOutline (false);
        barrenderer.setMaxBarWidth(0.05); // 5% of total width
        java.awt.GradientPaint gradientpaint = new GradientPaint (0.0F, 0.0F, java.awt.Color.red, 0.0F, 0.0F, new Color (0, 0, 64));
        java.awt.GradientPaint gradientpaint1 = new GradientPaint (0.0F, 0.0F, java.awt.Color.green, 0.0F, 0.0F, new Color (0, 64, 0));
        java.awt.GradientPaint gradientpaint2 = new GradientPaint (0.0F, 0.0F, java.awt.Color.cyan, 0.0F, 0.0F, new Color (64, 0, 0));
        barrenderer.setSeriesPaint (0, gradientpaint);
        barrenderer.setSeriesPaint (1, gradientpaint1);
        barrenderer.setSeriesPaint (2, gradientpaint2);
        barrenderer.setLabelGenerator(new LabelGenerator());
        barrenderer.setItemLabelsVisible(true);
        org.jfree.chart.labels.ItemLabelPosition itemlabelposition = new ItemLabelPosition(org.jfree.chart.labels.ItemLabelAnchor.INSIDE12, org.jfree.ui.TextAnchor.CENTER_RIGHT, org.jfree.ui.TextAnchor.CENTER_RIGHT, -1.5707963267948966D);
        barrenderer.setPositiveItemLabelPosition(itemlabelposition);
        org.jfree.chart.labels.ItemLabelPosition itemlabelposition1 = new ItemLabelPosition(org.jfree.chart.labels.ItemLabelAnchor.OUTSIDE12, org.jfree.ui.TextAnchor.CENTER_LEFT, org.jfree.ui.TextAnchor.CENTER_LEFT, -1.5707963267948966D);
        barrenderer.setPositiveItemLabelPositionFallback(itemlabelposition1);
        org.jfree.chart.axis.CategoryAxis categoryaxis = categoryplot.getDomainAxis ();
        categoryaxis.setCategoryLabelPositions (org.jfree.chart.axis.CategoryLabelPositions.createUpRotationLabelPositions (0.52359877559829882D));
        return jfreechart;
    }


  /*  public static org.jfree.chart.JFreeChart getChart (String title, String xAxisTitle, String yAxisTitle, CategoryDataset categoryDataset)
    {
        JFreeChart jfreechart = org.jfree.chart.ChartFactory.createAreaChart (title, xAxisTitle, yAxisTitle, categoryDataset, org.jfree.chart.plot.PlotOrientation.VERTICAL, true, true, false);
        jfreechart.setBackgroundPaint (java.awt.Color.white);
        org.jfree.chart.plot.CategoryPlot categoryplot = jfreechart.getCategoryPlot ();
        categoryplot.setBackgroundPaint (java.awt.Color.lightGray);
        categoryplot.setDomainGridlinePaint (java.awt.Color.white);
        categoryplot.setDomainGridlinesVisible (true);
        categoryplot.setRangeGridlinePaint (java.awt.Color.white);
        org.jfree.chart.axis.NumberAxis numberaxis = (org.jfree.chart.axis.NumberAxis)categoryplot.getRangeAxis ();
        numberaxis.setStandardTickUnits (org.jfree.chart.axis.NumberAxis.createIntegerTickUnits ());
        org.jfree.chart.renderer.category.AreaRenderer barrenderer = (org.jfree.chart.renderer.category.AreaRenderer)categoryplot.getRenderer ();
	//barrenderer.setDrawBarOutline(true);
        //barrenderer.setDrawBarOutline (false);
        //barrenderer.setMaxBarWidth(0.05); // 5% of toatal width
        java.awt.GradientPaint gradientpaint = new GradientPaint (0.0F, 0.0F, java.awt.Color.red, 0.0F, 0.0F, new Color (0, 0, 64));
        java.awt.GradientPaint gradientpaint1 = new GradientPaint (0.0F, 0.0F, java.awt.Color.green, 0.0F, 0.0F, new Color (0, 64, 0));
        java.awt.GradientPaint gradientpaint2 = new GradientPaint (0.0F, 0.0F, java.awt.Color.cyan, 0.0F, 0.0F, new Color (64, 0, 0));
        barrenderer.setSeriesPaint (0, gradientpaint);
        barrenderer.setSeriesPaint (1, gradientpaint1);
        barrenderer.setSeriesPaint (2, gradientpaint2);
        barrenderer.setLabelGenerator(new LabelGenerator());
        barrenderer.setItemLabelsVisible(true);
        org.jfree.chart.labels.ItemLabelPosition itemlabelposition = new ItemLabelPosition(org.jfree.chart.labels.ItemLabelAnchor.INSIDE12, org.jfree.ui.TextAnchor.CENTER_RIGHT, org.jfree.ui.TextAnchor.CENTER_RIGHT, -1.5707963267948966D);
        barrenderer.setPositiveItemLabelPosition(itemlabelposition);
        org.jfree.chart.labels.ItemLabelPosition itemlabelposition1 = new ItemLabelPosition(org.jfree.chart.labels.ItemLabelAnchor.OUTSIDE12, org.jfree.ui.TextAnchor.CENTER_LEFT, org.jfree.ui.TextAnchor.CENTER_LEFT, -1.5707963267948966D);
        //barrenderer.setPositiveItemLabelPositionFallback(itemlabelposition1);
        org.jfree.chart.axis.CategoryAxis categoryaxis = categoryplot.getDomainAxis ();
        categoryaxis.setCategoryLabelPositions (org.jfree.chart.axis.CategoryLabelPositions.createUpRotationLabelPositions (0.52359877559829882D));
        return jfreechart;
    }*/


    public static org.jfree.chart.JFreeChart getChart1 (String title, String xAxisTitle, String yAxisTitle, CategoryDataset categoryDataset)
    {
					logger.info("in getChart1() "+title+" "+xAxisTitle+" "+yAxisTitle+" "+categoryDataset);	
        JFreeChart jfreechart = org.jfree.chart.ChartFactory.createLineChart (title, xAxisTitle, yAxisTitle, categoryDataset, org.jfree.chart.plot.PlotOrientation.VERTICAL, true, true, false);
        jfreechart.setBackgroundPaint (java.awt.Color.white);
        org.jfree.chart.plot.CategoryPlot categoryplot = jfreechart.getCategoryPlot ();
        categoryplot.setBackgroundPaint (java.awt.Color.lightGray);
        categoryplot.setDomainGridlinePaint (java.awt.Color.white);
        categoryplot.setDomainGridlinesVisible (true);
        categoryplot.setRangeGridlinePaint (java.awt.Color.white);
        org.jfree.chart.axis.NumberAxis numberaxis = (org.jfree.chart.axis.NumberAxis)categoryplot.getRangeAxis ();
        numberaxis.setStandardTickUnits (org.jfree.chart.axis.NumberAxis.createIntegerTickUnits ());
        org.jfree.chart.renderer.category.LineAndShapeRenderer barrenderer = (org.jfree.chart.renderer.category.LineAndShapeRenderer)categoryplot.getRenderer ();
	//barrenderer.setDrawBarOutline(true);
        //barrenderer.setDrawBarOutline (false);
        //barrenderer.setMaxBarWidth(0.05); // 5% of total width
        java.awt.GradientPaint gradientpaint = new GradientPaint (0.0F, 0.0F, java.awt.Color.red, 0.0F, 0.0F, new Color (0, 0, 64));
        java.awt.GradientPaint gradientpaint1 = new GradientPaint (0.0F, 0.0F, java.awt.Color.green, 0.0F, 0.0F, new Color (0, 64, 0));
        java.awt.GradientPaint gradientpaint2 = new GradientPaint (0.0F, 0.0F, java.awt.Color.cyan, 0.0F, 0.0F, new Color (64, 0, 0));
        barrenderer.setSeriesPaint (0, gradientpaint);
        barrenderer.setSeriesPaint (1, gradientpaint1);
        barrenderer.setSeriesPaint (2, gradientpaint2);
        barrenderer.setLabelGenerator(new LabelGenerator());
        barrenderer.setItemLabelsVisible(true);
       org.jfree.chart.labels.ItemLabelPosition itemlabelposition = new ItemLabelPosition(org.jfree.chart.labels.ItemLabelAnchor.INSIDE12, org.jfree.ui.TextAnchor.CENTER_RIGHT, org.jfree.ui.TextAnchor.CENTER_RIGHT, 0.0);

        barrenderer.setPositiveItemLabelPosition(itemlabelposition);
        //org.jfree.chart.labels.ItemLabelPosition itemlabelposition1 = new ItemLabelPosition(org.jfree.chart.labels.ItemLabelAnchor.OUTSIDE12, org.jfree.ui.TextAnchor.CENTER_LEFT, org.jfree.ui.TextAnchor.CENTER_LEFT, -1.5707963267948966D);
        //barrenderer.setPositiveItemLabelPositionFallback(itemlabelposition1);
       
        //barrenderer.setPositiveItemLabelPosition(itemlabelposition1);
	org.jfree.chart.axis.CategoryAxis categoryaxis = categoryplot.getDomainAxis ();
        categoryaxis.setCategoryLabelPositions (org.jfree.chart.axis.CategoryLabelPositions.createUpRotationLabelPositions (0.52359877559829882D));
        return jfreechart;
    }
}

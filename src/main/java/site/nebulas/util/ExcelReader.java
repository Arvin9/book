package site.nebulas.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import site.nebulas.beans.Book;



public class ExcelReader {
	private POIFSFileSystem fs;
	private HSSFWorkbook wb;
	private HSSFSheet sheet;
	private HSSFRow row;
	


    /**
     * 读取Excel表格表头的内容
     * @param InputStream
     * @return String 表头内容的数组
     */
	private String[] readExcelTitle(InputStream is) {
		try {
			
            fs = new POIFSFileSystem(is);
            //获取excel工作薄对象
            wb = new HSSFWorkbook(fs);
        } catch (IOException e) {
            e.printStackTrace();
        }
		// 获取第一张工作表
        sheet = wb.getSheetAt(0);
        // 获取标题行，标题为第2行
        row = sheet.getRow(1);
        
        // 标题总列数
        int colNum = row.getPhysicalNumberOfCells();
        System.out.println("colNum:" + colNum);
        
        String[] title = new String[colNum];
        
        for (int i = 0; i < colNum; i++) {
            title[i] = getCellFormatValue(row.getCell(i));
        }
        return title;
	}
	
	
	 /**
     * 读取Excel数据内容
     * @param InputStream
     * @return List 包含单元格数据内容的List对象
     */
    public List<Book> readExcelContent(InputStream is) {
    	List<List<Book>> result = new ArrayList<>();
    	List<Book> list = new ArrayList<Book>();
        List<Book> content = new ArrayList<Book>();
        
        Book book = null;
        try {
        	
            fs = new POIFSFileSystem(is);
            wb = new HSSFWorkbook(fs);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sheet = wb.getSheetAt(0);
        // 得到总行数
        int rowNum = sheet.getLastRowNum();
        row = sheet.getRow(0);
        int colNum = row.getPhysicalNumberOfCells();
        //System.out.println(colNum);
        // 正文内容应该从第二行开始,第一行为表头的标题
        for (int i = 1; i <= rowNum; i++) {
        	
            row = sheet.getRow(i);
            //将获取的数据封装到Bookbean中
            book = new Book();
            book.setSerialNumber(getCellFormatValue(row.getCell(0)));
            book.setBookName(getCellFormatValue(row.getCell(1)));
            
            
        
            //容错性：作者为空
            if(!getCellFormatValue(row.getCell(2)).isEmpty()){
            	book.setBookAuthor(getCellFormatValue(row.getCell(2)));
            }else{
            	book.setBookAuthor("无");
            }
            //容错性：出版社为空
            if(!getCellFormatValue(row.getCell(3)).isEmpty()){
            	book.setBookConcern(getCellFormatValue(row.getCell(3)));
            }else{
            	book.setBookConcern("无");
            }
            //容错性：版次为空
            if(!getCellFormatValue(row.getCell(4)).isEmpty()){
            	book.setBookEdition(getCellFormatValue(row.getCell(4)));
            }else{
            	book.setBookEdition("无");
            }
            //容错性：定价为空
            if(!getCellFormatValue(row.getCell(5)).isEmpty()){
            	book.setBookPrice(getCellFormatValue(row.getCell(5)));
            }else{
            	book.setBookPrice("无");
            }
            //容错性：备注为空
            if(!getCellFormatValue(row.getCell(6)).isEmpty()){
            	book.setBookDesc(getCellFormatValue(row.getCell(6)));
            }else{
            	book.setBookDesc("无");
            }
                   
            content.add(book);  
        }
        return content;
    }

     



	

    
    /**
     * 根据HSSFCell类型设置数据
     * @param cell
     * @return
     */
    private String getCellFormatValue(HSSFCell cell) {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
	            // 如果当前Cell的Type为NUMERIC
	            case HSSFCell.CELL_TYPE_NUMERIC:           	
	            case HSSFCell.CELL_TYPE_FORMULA: {
	                // 判断当前的cell是否为Date
	                if (HSSFDateUtil.isCellDateFormatted(cell)) {
	                    // 如果是Date类型则，转化为Data格式
	                    
	                    //方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
	                    //cellvalue = cell.getDateCellValue().toLocaleString();
	                    
	                    //方法2：这样子的data格式是不带带时分秒的：2011-10-12
	                    Date date = cell.getDateCellValue();
	                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	                    cellvalue = sdf.format(date);
	                    
	                }
	                // 如果是纯数字
	                else {
	                    // 取得当前Cell的数值
	                    cellvalue = String.valueOf(cell.getNumericCellValue());
	                   
	                }
	                break;
	            }
	            // 如果当前Cell的Type为STRIN
	            case HSSFCell.CELL_TYPE_STRING:
	                // 取得当前的Cell字符串
	                cellvalue = cell.getRichStringCellValue().getString();
	                break;
	            // 默认的Cell值
	            default:
	                cellvalue = "";
	            }
        } else {
            cellvalue = "";
        }
       
        return cellvalue;

    }
    

    
	public static void main(String[] args) {
		InputStream is;
		
		try {
			//读取文件路径
			is = new FileInputStream("d:\\A.xls");
			
			ExcelReader excelReader = new ExcelReader();
			
			//读取excel标题
	        String[] title = excelReader.readExcelTitle(is);
	        
	        System.out.println("获得Excel表格的标题:");
	        for (String s : title) {
                System.out.print(s + " ");
            }
	        
	     
	     // 对读取Excel表格内容测试
            InputStream is2 = new FileInputStream("d:\\A.xls");
            List<Book> list = excelReader.readExcelContent(is2);
            System.out.println("获得Excel表格的内容:");
            for (int i = 1; i < list.size(); i++) {
                System.out.println(list.get(i).getBookName()+" "+list.get(i).getSerialNumber()+" "+list.get(i).getBookAuthor()+" "+list.get(i).getBookConcern()+" "+list.get(i).getBookDesc()+" "+list.get(i).getBookEdition());
                
               
            }
	        
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}
    
    
}

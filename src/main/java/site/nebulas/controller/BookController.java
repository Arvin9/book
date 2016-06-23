package site.nebulas.controller;




import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;




import site.nebulas.beans.Book;
import site.nebulas.service.BookService;
import site.nebulas.util.ExcelReader;
import site.nebulas.util.Response;



@Controller
public class BookController {
	Logger log=LoggerFactory.getLogger(getClass());
	
	@Resource
	private BookService bookService;
	
	
	
	@RequestMapping("book")
	public ModelAndView operationLog(){
		ModelAndView modelAndView = new ModelAndView("book");
		return modelAndView;
	}
	
	@RequestMapping("bookQueryByParam")
	@ResponseBody
	public Object bookQueryByParam(Book book) {
		return bookService.bookQueryByParam(book);
	}
	
	@RequestMapping("addBook")
	@ResponseBody
	public Object addBook(Book book){
		Response response = new Response();	
		bookService.insert(book);
		return response;
	}
	
	@RequestMapping("addBookBatch")
	@ResponseBody
	public Object addBookBatch(@RequestParam("uploadBookBatch")MultipartFile uploadBookBatch){
		Response response = new Response();
		
		try {
			if (uploadBookBatch!=null && !uploadBookBatch.isEmpty()) {
				ExcelReader excelReader = new ExcelReader();			
				InputStream is;
				is = uploadBookBatch.getInputStream();
				List<Book> list = excelReader.readExcelContent(is);
				log.info("\nlist "+list);
		        //获取list中图书信息，并写入数据库
		        for (int i = 0; i < list.size(); i++) {	            
		            bookService.insert(list.get(i));					       
		        }
				
			}
		} catch (Exception e) {
			response.setRet(500);
		}		
		return response; 
	}

	

	
	/*
	

	
	@RequestMapping("updateBook")
	@ResponseBody
	public Object updateBook(Book book){
		Response response = new Response();
		book.setUpdateTime(DateUtil.getDateTimeString(new Date()));
		bookService.update(book);
		return response;
	}
	
	@RequestMapping("deleteBook")
	@ResponseBody
	public Object deleteBook(Book book){
		Response response = new Response();
		bookService.delete(book);
		return response;
	}
	*/
}





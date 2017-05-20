package com.growth.web;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.growth.service.FileService;

@Controller
public class ImageController {
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private ServletContext context;
	@RequestMapping("/image.do")
	public ResponseEntity<byte[]>  getImageAsByteStream(HttpServletResponse response,String id) throws Exception{
		
		final HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.IMAGE_PNG);

		 
		 return new ResponseEntity<byte[]>(fileService.selectFileBlobData(id).getFileData(), headers, HttpStatus.CREATED);
	}
}

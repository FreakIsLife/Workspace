package com.zhku.jsj.utils.upload;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import com.zhku.jsj.utils.common.PicUtils;

public class FileItemUtil {

	public static String doFileUpload(HttpServletRequest request, String type,
			int x, int y) {
		try {
			Part part = request.getPart(type);
			String fileName = part.getSubmittedFileName();
			// 判断是否传入图片，没有则返回空串
			if ("".equals(fileName)) {
				return "";
			}
			// 获取文件名
			int index = fileName.lastIndexOf("\\");
			if (index != -1) {
				fileName = fileName.substring(index + 1);
			}
			// 获得随机不重复的文件名
			String uuidname = UploadUtils.generateRandonFileName(fileName);

			// /1/5
			String randomDir = UploadUtils.generateRandomDir(uuidname);

			String imageurl = "/images" + randomDir;
			String realPath = request.getSession().getServletContext()
					.getRealPath("/images");
			// d:/a/b/c/day15/images/1/5
			String newPath = realPath + randomDir;

			File fileDir = new File(newPath);

			if (!fileDir.exists()) {
				fileDir.mkdirs();
			}
			// 将文件写到项目的路径下
			part.write(newPath + "/" + uuidname);
			// d:/a/b/c/day15/image/1/5 jlkfdsjalkfjdslk.png
			File file = new File(newPath, uuidname);
			// 生成一个小图片 保存 到 原 文件同样的文件夹 下
			// 返回 文件 跟 系统相关的 一个 实际的 路径
			PicUtils pic = new PicUtils(file.getCanonicalPath());
			pic.resize(x, y);
			// 返回图片存放的相对路径
			return imageurl + "/" + uuidname;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static void deleteOldImg(HttpServletRequest request, String path) {
		// 获取tomcat部署项目的路径
		String realPath = request.getSession().getServletContext()
				.getRealPath("/");
		// 获取大图片的路径
		File fileImg = new File(realPath + path);
		// 如果文件存在就删除他
		if (fileImg.exists()) {
			fileImg.delete();
		}
		// 获取small图片的路径
		int Index = path.lastIndexOf(".");
		String smallPath = path.substring(0, Index) + "_small"
				+ path.substring(Index);
		File fileSmallImg = new File(realPath + smallPath);
		// 如果文件存在就删除他
		if (fileSmallImg.exists()) {
			fileSmallImg.delete();
		}
	}
}

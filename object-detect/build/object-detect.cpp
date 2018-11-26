
#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <librealsense2/rs.hpp> // Include RealSense Cross Platform API
#include "opencv2/imgproc/imgproc.hpp"
 #include "opencv2/opencv.hpp"
using namespace std;
using namespace cv;
void mask_depth(Mat &image,Mat& th,int throld=1000)
{
int nr = image.rows; // number of rows 
int nc = image.cols; // number of columns 
for (int i = 0; i<nr; i++)
{
 
for (int j = 0; j<nc; j++) {
if (image.at<ushort>(i, j)>throld)
th.at<ushort>(i, j) = 0;
}
}
 
}
vector<vector<Point> > find_obstacle(Mat &depth, int thresh = 20, int max_thresh = 255, int area = 500)
{
	Mat dep;
	depth.copyTo(dep);
	mask_depth(depth, dep, 1000);
	dep.convertTo(dep, CV_8UC1, 1.0 / 16);
	//imshow("color", color);
	imshow("depth", dep);
	Mat element = getStructuringElement(MORPH_RECT, Size(15, 15));//核的大小可适当调整
	Mat out;
	//进行开操作
	morphologyEx(dep, out, MORPH_OPEN, element);
	//dilate(dhc, out, element);

	//显示效果图
	imshow("opencv", out);
	Mat src_copy = dep.clone();
	Mat threshold_output;
	vector<vector<Point> > contours;
	vector<Vec4i> hierarchy;
	RNG rng(12345);
	/// 对图像进行二值化
	threshold(dep, threshold_output, thresh, 255, CV_THRESH_BINARY);
	//mask_depth(src, threshold_output);
	/// 寻找轮廓
	findContours(threshold_output, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, Point(0, 0));

	/// 对每个轮廓计算其凸包
	vector<vector<Point> >hull(contours.size());
	vector<vector<Point> > result;
	for (int i = 0; i < contours.size(); i++)
	{
		convexHull(Mat(contours[i]), hull[i], false);

	}

	/// 绘出轮廓及其凸包
	Mat drawing = Mat::zeros(threshold_output.size(), CV_8UC3);
	for (int i = 0; i< contours.size(); i++)
	{
		if (contourArea(contours[i]) < area)//面积小于area的凸包，可忽略
			continue;
		result.push_back(hull[i]);
		Scalar color = Scalar(rng.uniform(0, 255), rng.uniform(0, 255), rng.uniform(0, 255));
		drawContours(drawing, contours, i, color, 1, 8, vector<Vec4i>(), 0, Point());
		drawContours(drawing, hull, i, color, 1, 8, vector<Vec4i>(), 0, Point());
	}
	imshow("contours", drawing);
	return result;
}


int main(int argc, char* argv[])
{
	rs2::colorizer color_map;
	rs2::pipeline pipe;
	pipe.start();
	
 	/*const auto window_name = "Display Image";
    namedWindow(window_name, WINDOW_AUTOSIZE);*/
	while (waitKey(1) < 0 /*&& cvGetWindowHandle(window_name)*/)
	{
		rs2::frameset data = pipe.wait_for_frames(); // Wait for next set of frames from the camera
        rs2::frame depth = data.get_depth_frame().apply_filter(color_map);
		const int w = depth.as<rs2::video_frame>().get_width();
        const int h = depth.as<rs2::video_frame>().get_height();
		Mat image(Size(w, h), CV_8UC3, (void*)depth.get_data(), Mat::AUTO_STEP);

		vector<vector<Point> > result;
		result = find_obstacle(image, 20, 255, 500);

		if (cvWaitKey(1) == 27)
			break;
	}
 
	return EXIT_SUCCESS;
}
catch (const rs2::error & e)
{
    std::cerr << "RealSense error calling " << e.get_failed_function() << "(" << e.get_failed_args() << "):\n    " << e.what() << std::endl;
    return EXIT_FAILURE;
}
catch (const std::exception& e)
{
    std::cerr << e.what() << std::endl;
    return EXIT_FAILURE;
}
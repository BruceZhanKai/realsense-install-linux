#include <librealsense2/rs.hpp>
#include "example.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc.hpp>
 
#include <sstream>
#include <iostream>
#include <iomanip>
#include <thread>
 
using namespace cv;
using namespace std;
 
struct rgb_pixel
{
    uint8_t r,g,b;
};
 
int main()
{
    rs2::log_to_console(rs2_log_severity::warn);
    rs2::context ctx;
    rs2::device & dev = *ctx.get_device(0);
    dev.enable_stream(rs2::stream::color, 640, 480, rs2::format::rgb8, 60);
    dev.enable_stream(rs2::stream::depth, 640, 480, rs2::format::z16, 60);
    dev.start();
 
    while(1)
        {
            dev.wait_for_frames();
            uchar* pRgb = (uchar*)dev.get_frame_data(rs2::stream::color);
            uint16_t *depthImage = (uint16_t *) dev.get_frame_data(rs2::stream::depth);
            uchar* pCad = (uchar*)dev.get_frame_data(rs2::stream::color_aligned_to_depth);
            Mat rgb_show;
            Mat rgb(480, 640, CV_8UC3, pRgb);
            cvtColor(rgb, rgb_show, CV_BGR2RGB);
            imshow("RGBImage",rgb_show);
            Mat depth(480,640,CV_16UC1, depthImage);
            imshow("Depthimage",depth*15);
            Mat cad_show;
            Mat cad(480, 640, CV_8UC3, pCad);
            cvtColor(cad, cad_show, CV_BGR2RGB);
            imshow("CADImage",cad_show);
            waitKey(10);
        }
	return 0;
}
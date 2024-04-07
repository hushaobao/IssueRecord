## 1. 超分辨

### DataSets

- RGB  

  > Set5、Set14、Urban100、Sun-Hays 80、Manga109、historical General100、T91、BSD100、BSD200、BSD300、BSD500、City100、DIV2K、Waterloo、W2S 、SR-RAW、PIPAL、CUFED（The CUration of Flickr Events Dataset）、DPED、DRealSR、Real SR、Flickr2K、DF2K、OST (Outdoor Scenes)、PIRM   
  > ————————————————   
  > https://blog.csdn.net/qq_41554005/article/details/116466156

- IR  

  > M3FD FLIR_ADAS  
  > others: Infrared Image Super-Resolution: Systematic Review, and Future Trends [[paper]](https://arxiv.org/pdf/2212.12322)



### Method

#### 传统算法

插值方法、基于稀疏表示（字典学习）方法、基于局部嵌入、Example-Based

方案原理介绍 https://blog.csdn.net/SimonCoder/article/details/102956589

1. 插值方法  

> bilinear、bicubic、lanczos、nearest

2. 基于稀疏表示（字典学习）方法  

> - Image Super-Resolution as Sparse Representation of Raw Image Patches（CVPR2008）
>
> - Image Super-Resolution Via Sparse Representation（TIP2010）
>
> - Robust Single-Image Super-Resolution Based on Adaptive Edge-Preserving Smoothing Regularization（TIP2018）

3. 基于局部嵌入

> - Image Super-Resolution With Sparse Neighbor Embedding（TIP2012）

4. Example-Based

> - Image and Video Upscaling from Local Self-Examples （TOG2011）
>
> - Anchored Neighborhood Regression for Fast Example-Based Super-Resolution（ICCV2013）
>
> - Learning Super-Resolution Jointly From External and Internal Examples（TIP2015）



这些方法都比较老，且超分效果一般，不采用传统算法实现超分

#### 基于深度学习算法

CNN、GAN、Transformer

> 经典论文概述：
>
> https://zhuanlan.zhihu.com/p/104407869
>
> https://zhuanlan.zhihu.com/p/558813267



- NTIRE竞赛

[[2022 paper]](https://openaccess.thecvf.com/content/CVPR2022W/NTIRE/papers/Li_NTIRE_2022_Challenge_on_Efficient_Super-Resolution_Methods_and_Results_CVPRW_2022_paper.pdf)

[[2023 paper]](https://openaccess.thecvf.com/content/CVPR2023W/NTIRE/papers/Zhang_NTIRE_2023_Challenge_on_Image_Super-Resolution_x4_Methods_and_Results_CVPRW_2023_paper.pdf)

2022冠军方案：RLFN: Residual Local Feature Network for Efficient Super-Resolution [[paper\]](https://openaccess.thecvf.com/content/CVPR2022W/NTIRE/papers/Kong_Residual_Local_Feature_Network_for_Efficient_Super-Resolution_CVPRW_2022_paper.pdf) [[test code\]](https://github.com/bytedance/RLFN)

2023冠军方案：DIPNet: Efficiency Distillation and Iterative Pruning for Image Super-Resolution [[知乎解读]](https://zhuanlan.zhihu.com/p/641077705) [[paper]](https://openaccess.thecvf.com/content/CVPR2023W/NTIRE/papers/Yu_DIPNet_Efficiency_Distillation_and_Iterative_Pruning_for_Image_Super-Resolution_CVPRW_2023_paper.pdf) [[test code]](https://github.com/xiumu00/DIPNet/blob/master)      —— RLFN的改进版，trick可以做参考

- CVPR Workshop: 

Real-Time Quantized Image Super-Resolution on Mobile NPUs, Mobile AI 2021 Challenge: Report [[paper]](https://openaccess.thecvf.com/content/CVPR2021W/MAI/papers/Ignatov_Real-Time_Quantized_Image_Super-Resolution_on_Mobile_NPUs_Mobile_AI_2021_CVPRW_2021_paper.pdf)

Efficient and Accurate Quantized Image Super-Resolution on Mobile NPUs, Mobile AI & AIM 2022 challenge: Report [[paper]](https://arxiv.org/pdf/2211.05910.pdf)

- 超分算法训练工具箱

https://hub.yzuu.cf/XPixelGroup/BasicSR

https://github.com/HeaseoChung/SR-Trainer

- 最新论文代码汇总：

https://github.com/ChaofWang/Awesome-Super-Resolution



- 自然光相关论文

轻量级网络：

✔Anchor-based Plain Net for Mobile Image Super-Resolution [[code]](https://hub.yzuu.cf/NJU-Jet/SR_Mobile_Quantization)

✔SplitSR: An End-to-End Approach to Super-Resolution on Mobile Devices [[paper\]](https://arxiv.org/pdf/2101.07996.pdf)  [[code\]](https://hub.yzuu.cf/deepconsc/SplitSR/blob/master/modules/blocks.py)

❌ClassSR: A General Framework to Accelerate Super-Resolution Networks by Data Characteristic  论文无实际运行速度 只有参数了  网络层数太多

✔Extremely Lightweight Quantization Robust Real-Time Single-Image Super Resolution for Mobile Device  [[code\]](https://hub.yzuu.cf/cxzhou95/XLSR/tree/main)

RenderSR: A Lightweight Super-Resolution Model for Mobile Gaming Upscalin

Equivalent Transformation and Dual Stream Network Construction for Mobile Image Super-Resolution [[code]](https://hub.yzuu.cf/ECNUSR/ETDS/blob/master/core/archs/ir/ETDS/arch.py)

- 红外相关论文

专门做这部分的比较少（开源少），一般都是拿自然光超分辨方法去做的，不同点是图像的退化处理（训练数据）有差异

综述：Infrared Image Super-Resolution: Systematic Review, and Future Trends [[paper\]](https://arxiv.org/pdf/2212.12322) [[repo\]](https://github.com/yongsongH/Infrared_Image_SR_Survey)

研究者GitHub主页：https://hub.yzuu.cf/yongsongH/

红外超分辨demo视频（代码未开源）：https://mire-planet-69a.notion.site/IR-Super-Resolution-in-Jetson-17993a54fa6749dcbec4cca88b749641



基于CNN: A Lightweight Iterative Error Reconstruction Network for Infrared Image Super-Resolution in Smart Grid [[paper\]](https://www.sciencedirect.com/science/article/abs/pii/S221067072030737X) [[code\]](https://github.com/Lihui-Chen/IERN-for-IR-Image-SR)

基于GAN: Infrared Image Super-Resolution via Transfer Learning and PSRGAN [[paper\]]() [[code\]](https://github.com/yongsongH/Infrared_Image_SR_PSRGAN)

基于GAN: Rethinking Degradation: Radiograph Super-Resolution via AID-SRGAN [[paper\]](https://arxiv.org/pdf/2208.03008.pdf) [[code\]](https://github.com/yongsongH/AIDSRGAN-MICCAI2022)

基于GAN: https://hub.yzuu.cf/HeGuannan-duludulu/IRSRGAN



这里的基于GAN红外超分算法可以做些参考，但考虑到耗时问题，暂不考虑；

基于CNN方法，耗时不高可以考虑使用（备选方案）



- 视频超分：

https://github.com/coulsonlee/STDO-CVPR2023

https://github.com/ECNUSR/PureConvSR-AIM2022



#### 实现关键代码

基于 https://hub.yzuu.cf/NJU-Jet/SR_Mobile_Quantization + SR-Trainer


```python
 
 # model.py
 import torch.nn as nn
 import torch
 import numpy as np
 
 class Generator(nn.Module):
     def __init__(self, cfg):
         super(Generator, self).__init__()
 
         self.conv1 = nn.Conv2d(3, 28, 3, stride=1, padding=1, bias=True)
         self.relu1 = nn.ReLU(inplace=True)
         
         conv_blok = []
         for _ in range(4):
             conv_blok.append(nn.Conv2d(28, 28, 3, stride=1, padding=1, bias=True))
             conv_blok.append(nn.ReLU(inplace=True))
         self.conv_block = nn.Sequential(*conv_blok)
         self.conv2 = nn.Conv2d(28, 3, 3, stride=1, padding=1, bias=True)
         self.deconv = nn.ConvTranspose2d(3, 3, kernel_size=4, stride=2, padding=(4 - 2)//2)
     def forward(self, x):
         out_feature = self.relu1(self.conv1(x))
         out1 = self.conv_block(out_feature)
         out2 = self.conv2(out1)
         from IPython import embed
         # embed()
         output = self.deconv(x + out2)
         return output
```



#### 难点

- **训练数据的制作**：网络的训练需要对原始图像做降采样处理，以获取从成对的训练数据。红外图像不同于自然光图像，简单的resize以及噪声处理并不能模拟真实情况，需要针对红外数据做专门的降采样处理
- 模型部署及在板端上的耗时：
- 视频序列超分辨结果的风格一性：预计需要增加时序信息

#### 局限性

- 基于数据驱动，一定程度受相机ISP影响，相机isp和训练数据差异过大时，超分效果不能保证

延伸

- 双光融合+超分辨



## 2. 双光融合

可见光与红外图像融合（Visible and infrared image fusion）：其目的是将可见光和红外图像的信息进行互补，达到更好的图像质量，用作显示或下游任务。

可见光与红外图像融合（Visible and infrared image fusion）是图像融合领域的一个分支。其目的是将可见光和红外图像融合起来得到一幅融合图像，并且在融合图像中保留源图像的主要信息

这样做的主要原因是因为可见光和红外图像包含互补的信息。例如，**可见光图像容易受光照影响但包含很多细节信息，而红外图像不易受光照影响但是缺乏细节信息**

#### 算法分类

融合方法有以下两类：

- 传统算法：基于空间域的、基于变换域

  Two-scale image fusion of visible and infrared images using saliency detection

- 基于深度学习方法：CNN、AutoEncoder、GAN、Transformer

这些算法一般是无监督算法

基于空间域的方法是指直接在空间域对源图像进行操作从而得到融合图像的方法，主要包含基于像素的(pixel-based)、基于块的(block-based)和基于区域(region-based)的方法。

基于变换域的方法是指首先将源图像变换到某个变换域，然后在该变换域内进行图像融合（一般以系数的形式），最后再用逆变换得到融合图像的过程。常用的变换包括多尺度变换（例如小波变换）、压缩感知、稀疏表达等。

https://mp.weixin.qq.com/s/KB-f8maHuWZLUbvbxUrPxw （主要是15-20年的传统算法） https://hub.yzuu.cf/xingchenzhang/VIFB https://hub.yzuu.cf/wangyujie28/VIFB_ALGO



自编码器、CNN、GAN

任务驱动：SeAFusion



#### 相关算法

Visible and Infrared Image Fusion Using Deep Learning

https://arxiv.org/pdf/2002.03322.pdf

https://zhuanlan.zhihu.com/p/342971809

https://zhuanlan.zhihu.com/p/508022886

https://hub.yzuu.cf/Linfeng-Tang/Image-Fusion



https://zhuanlan.zhihu.com/p/259361666

Two-Scale Image Fusion of Infrared and Visible Images Using Saliency Detection

 PAIF: Perception-Aware Infrared-Visible Image Fusion for Attack-Tolerant Semantic Segmentation [[paper\]](https://arxiv.org/pdf/2308.03979.pdf) [[code\]](https://hub.yzuu.cf/LiuZhu-CV/PAIF)



红外图像融合+分割

https://hub.yzuu.cf/JinyuanLiu-CV/SegMiF



配准+融合：

https://rsliu.tech/Publication.html

https://hub.yzuu.cf/dlut-dimt

ReCoNet-Recurrent Correction Network for Fast and Efficient Multi-modality Image Fusion [[code\]](https://hub.yzuu.cf/dlut-dimt/ReCoNet)

Unsupervised Misaligned Infrared and Visible Image Fusion via Cross-Modality Image Generation and Registration

此外，最近研究出现配准+融合的端到端模型（如UMF-CMGR），但考虑到其模型结构复杂以及其只对简单场景有效，故不采取此类方案。



#### TIF算法实现


```c++
// c++ 
#include <iostream>
 #include <vector>
 #include <chrono>
 
 #include <opencv2/core.hpp>
 #include <opencv2/imgcodecs.hpp>
 #include <opencv2/imgproc.hpp>
 
 #define MEDIAN_BLUR_N 3
 #define MEAN_BLUR_N 35
 
 void TIF(const cv::Mat &vis, const cv::Mat &ir, cv::Mat &fusion)
 {
     int h = vis.rows, w = vis.cols, c = vis.dims;
     cv::Mat vis_f(h, w, CV_32FC3), ir_f(h, w, CV_32FC3);
     // cv::Mat vis_sub_mean(h, w, CV_32FC3), ir_sub_mean(h, w, CV_32FC3);
     // cv::Mat vis_mean_blur(h, w, CV_32FC3), ir_mean_blur(h, w, CV_32FC3);
     // cv::Mat vis_median_blur(h, w, CV_32FC3), ir_median_blur(h, w, CV_32FC3);
     // cv::Mat vis_median_sub_mean(h, w, CV_32FC3), ir_median_sub_mean(h, w, CV_32FC3);
     cv::Mat vis_sub_mean, ir_sub_mean;
     cv::Mat vis_mean_blur, ir_mean_blur;
     cv::Mat vis_median_blur, ir_median_blur;
     cv::Mat vis_median_sub_mean, ir_median_sub_mean;
 
     vis.convertTo(vis_f, CV_32FC3);
     ir.convertTo(ir_f, CV_32FC3);
 
     cv::blur(vis_f, vis_mean_blur, cv::Size(MEAN_BLUR_N, MEAN_BLUR_N));
     cv::blur(ir_f, ir_mean_blur, cv::Size(MEAN_BLUR_N, MEAN_BLUR_N));
 
     cv::medianBlur(vis_f, vis_median_blur, MEDIAN_BLUR_N);
     cv::medianBlur(ir_f, ir_median_blur, MEDIAN_BLUR_N);
 
     vis_sub_mean = vis_f - vis_mean_blur;
     ir_sub_mean = ir_f - ir_mean_blur;
 
     vis_median_sub_mean = vis_median_blur - vis_mean_blur;
     ir_median_sub_mean = ir_median_blur - ir_mean_blur;
 
     cv::Mat delta1 = vis_median_sub_mean.mul(vis_median_sub_mean);
     cv::Mat delta2 = ir_median_sub_mean.mul(ir_median_sub_mean);
     // cv::Mat delta2 = cv::abs(ir_median_sub_mean);
     cv::Mat delta = delta1 + delta2;
 
     cv::Mat psi_1 = delta1 / (delta + 1e-6);
     cv::Mat psi_2 = delta2 / (delta + 1e-6);
 
     cv::Mat p_b = 0.5f * (vis_mean_blur + ir_mean_blur);
     cv::Mat p_d = psi_1.mul(vis_sub_mean) + psi_2.mul(ir_sub_mean);
     fusion = p_b + p_d;
 }
 
 int main()
 {
     char path1[] = "data/vis/00010N.png";
     char path2[] = "data/ir/00010N.png";
     cv::Mat image_vis = cv::imread(path1);
     cv::Mat image_ir = cv::imread(path2);
     cv::Mat image_fusion;
     for (int i = 0; i < 100; i++)
     {
         auto time1 = std::chrono::high_resolution_clock::now();
         TIF(image_vis, image_ir, image_fusion);
         auto time2 = std::chrono::high_resolution_clock::now();
         auto sumer = std::chrono::duration_cast<std::chrono::microseconds>(time2 - time1).count();
         std::cout << "sumer time: " << sumer / 1000.f << std::endl;
     }
 
     cv::imwrite("data/cpp_res/00010N.png", image_fusion);
     return 0;
 }
 
```



```python
# python 
def TIF(p1, p2, median_blur_value=3, mean_blur_value=35):
     b1 = cv2.blur(p1.astype(np.float32), (mean_blur_value, mean_blur_value))
     b1 = b1.astype(np.float32)
     Med1 = cv2.medianBlur(p1.astype(np.float32), median_blur_value)
     d1 = p1.astype(np.float32) - b1
     S1 = b1 - Med1.astype(np.float32) + 1e-6
     S1 = S1 * S1
     
     Med2= cv2.medianBlur(p2.astype(np.float32), median_blur_value)
     b2 = cv2.blur(p2.astype(np.float32), (mean_blur_value, mean_blur_value))
     b2 = b2.astype(np.float32)
     d2 = p2.astype(np.float32) - b2
     S2 = b2 - Med2.astype(np.float32) + 1e-6
     S2 = abs(S2)
     # from IPython import embed
     # embed()
     
     w1 = S1 / (S1+S2)
     w2 = S2 / (S1+S2)
     F1 = w1 * d1 + w2 * d2
     F2 = 0.5 * b1 + 0.5 * b2
     FF = F1 + F2
     return FF
 
 # use
 # p1 = cv2.imread(path1, cv2.IMREAD_COLOR)  # 按彩色图像读取
 # p2 = cv2.imread(path2, cv2.IMREAD_COLOR)  # .astype(np.float)
 # p = TIF(p1, p2)  # 采用TIF方法进行融合
```



## 3. 伪彩

伪彩色图像是指指按照特定的准则对灰度图像进行处理，将不同的灰度级按照某种映射关系变换为不同的颜色分量，构造为彩色效果的图像。伪彩色图像在形式和视觉表现为彩色图像，但其所呈现的颜色并非图像的真实色彩重现，仅仅是各颜色分量的像素值合成的结果。

伪彩原理：将红外灰度图像进行伪彩色增强，基于设定的颜色查找表，将图像像素的灰度值替换为颜色查找表中对应的颜色值。

#### 算法分类

传统算法：

深度学习方法：真值获取问题，不建议使用



重点目标伪彩算法：

step1：目标检测+策略得到目标检测bbox

step2：使用伪彩算法/分割算法/显著性检测等算法实现重点目标着色渲染



#### OpenCV简单实现

```python
 # code sample
 
 def pesudoColor(img):
 
     img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
     ans = cv2.applyColorMap(img_gray, cv2.COLORMAP_TURBO)
     return ans
 
```



## 4. 真彩

将红外图像转换成RGB可见光图像

#### 相关算法

图像上色算法：https://hub.yzuu.cf/MarkMoHR/Awesome-Image-Colorization

- UNet/pip2pix/CycleGAN
- DDColor: 基于Transformer https://github.com/piddnad/DDColor  部署困难 从网上搜索出来的黑白图像，存在不少失败（效果差）的图像
- I2V-GAN: https://github.com/BIT-DA/I2V-GAN  数据集是2w 256x256 ir-vision图像对

I2V-GAN 场景比较单一，对ReCycleGAN的改进版本 Cyclist的效果较一般，不如pix2pix

训练数据：**RGB-IR图像对** / 非成对的RGB-IR数据

#### 难点

- 训练数据集制作
- 模型的部署问题

#### 局限

- 耗时问题（输入分辨率大的话会很耗时）
- 泛化性问题












# <center>FPGA 自学指南</center>

## 友情链接

- [**南工在线**](http://online.njtech.edu.cn)
- [**FPGA模块**]( https://github.com/NjtechPrinceling/PrincelingModuleHub )
- [**基于FPGA的五子棋**](https://github.com/Starrynightzyq/ZYNQ-PYNQ-Z2-Gobang)
  - 第二届全国大学生FPGA设计竞赛全国一等奖、最佳创意奖
  - 用硬件加速五子棋算法
  - 来自学长：周玉乾

## 更新日志

> @2019年11月25日
>
> @王磊
>
> 创建此仓库，用于南京工业大学电子FPGA自学，持续更新
>
> 增加了Digital-Design-Lab
>
> 增加了boards
>
> @2019年11月29日
>
> @王磊
>
> 更新了一些ReadMe的小错误
>
> 增加板块 成为 Xilinx FPGA 高手之路
>
> 增加文件夹 74IP
>
> 增加文件夹 HowToStudy
>
> 删除文件夹 74IP 转移到 Hub 里

## <center>上手之前须知</center>

1. `Vivado` 不能解析中文路径，请确保自己的工程目录没有英文，否则综合**必定失败**

2. 每个人都应该会使用 **GitHub**
   
   1. [廖雪峰的git教程]( https://www.liaoxuefeng.com/wiki/896043488029600 )。
   
3. <span id="boardIntroduction">板卡文件如何使用？</span>

   [答案戳这里]( https://reference.digilentinc.com/vivado/installing-vivado/2018.2 )

4. 成为 Xilinx FPGA 高手之路

   - [Digilent OpenSource IPCore]( https://github.com/Digilent/vivado-library)

   - [黑金 Xilinx 例程仓库](https://github.com/alinxalinx )
   - [ZYNQ自学指南]( http://adiuvoengineering.com/microzed-chronicles/?tdsourcetag=s_pctim_aiomsg)

## <center>文档内容说明</center>

### EGO_1_Lab

#### 0-EGo1资料文档-v1.1

一些EGO开发板的原理图，硬件手册，用户手册，引脚约束

#### 3-EGo配套实验

手把手教你学习EGO1，一些即开即用的程序。

### Digital-Design-Lab

我们专业学习FPGA的课本(是很好的一本书)对应的源码

能够直接用的开发板有`basys3`和`EGO-1`。

### HowToStudy

#### GettingStart

里面有一些入门的文档，包括一些电子图书。

> 但是FPGA毕竟是一门需要实践的课程。
>
> 如果你有现成的FPGA开发板，直接看3-EGO配套实验，手把手教学效果一定会更好。
>
> 如果在平时没有开发板时，也想学习，可以阅读该文档的内容。

#### HowToDevelop

华为的verilog编程规范、开发经验。

其中 `《华为verilog编程规范》`相当重要，一个好的编程习惯使你受益终生。

### boards

Digilent最新的板卡文件。如何使用请看[这里](#boardIntroduction)。
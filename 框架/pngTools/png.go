package main

import (
	"flag"
	"image"
	"image/png"
	"log"
	"os"
)

func rotate90(m image.Image) image.Image {
	rotate90 := image.NewRGBA(image.Rect(0, 0, m.Bounds().Dy(), m.Bounds().Dx()))
	// 矩阵旋转
	for x := m.Bounds().Min.Y; x < m.Bounds().Max.Y; x++ {
		for y := m.Bounds().Max.X - 1; y >= m.Bounds().Min.X; y-- {
			//  设置像素点
			rotate90.Set(m.Bounds().Max.Y-x, y, m.At(y, x))
		}
	}
	return rotate90
}

func main() {
	var src string
	var dest string
	flag.StringVar(&src, "i", "", "输入文件")
	flag.StringVar(&dest, "o", "", "输出文件")

	flag.Parse()

	if src == "" {
		log.Println("缺少-i参数,需要输入png文件")
	}
	if dest == "" {
		log.Println("缺少-o参数,需要输出png文件名")
	}

	f1, err := os.Open(src)
	if err != nil {
		log.Println(err)
		return
	}
	defer f1.Close()
	img, err := png.Decode(f1)
	if err != nil {
		log.Println(err)
		return
	}
	outimage := rotate90(img)

	f2, err := os.Create(dest)
	if err != nil {
		log.Println(err)
		return
	}
	defer f2.Close()

	err = png.Encode(f2, outimage)
	if err != nil {
		log.Println(err)
		return
	}
}

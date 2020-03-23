# printtools

Small tools for processing and printing files
I use with Thunar 

Direct Print Black & White Low Quality

lp -d BROLPD -o BRMonoColor=Mono -o BRResolution=PlainFast %f

N-UP pages
pdfnup --nup 2x2 %F 

CROP A6 on A4 
crop-pdf %f 25 410 585 290

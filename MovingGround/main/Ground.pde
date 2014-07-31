public class Ground {
  int segments;
  int ground_type;  // 0 = Bottom
  Ground_Seg[] ground_seg;
  float[] peakHeights;
  
  // Constructor
  Ground(int segments, int ground_type, int pad_height, int peak_height){
    this.segments = segments;
    this.ground_type = ground_type;
    
    ground_seg = new Ground_Seg[segments];
    peakHeights = new float[segments+1];
  
    // Bottom
    if(ground_type == 0){
        for (int i=0; i <peakHeights.length; i++){
          peakHeights[i] = random(height - pad_height - peak_height, height - pad_height);
        }
        float segs = segments;
        for (int i=0; i<segments; i++){
          ground_seg[i]  = new Ground_Seg(width*1.4/segs*i, peakHeights[i], width/segs*1.4*(i+1), peakHeights[i+1]);
        }
        Translate(-(int)(width*0.2), 0);
    }
    // Right
    if(ground_type == 1){
        for (int i=0; i <peakHeights.length; i++){
          peakHeights[i] = random(width - pad_height - peak_height, width - pad_height);
        }
        float segs = segments;
        for (int i=0; i<segments; i++){
          ground_seg[i]  = new Ground_Seg(peakHeights[i], height*1.4/segs*i, peakHeights[i+1], height/segs*1.4*(i+1));
        }
        Translate(0,-(int)(height*0.1));
    }
    //Top
    if(ground_type == 2){
        for (int i=0; i <peakHeights.length; i++){
          peakHeights[i] = random(pad_height, peak_height);
        }
        float segs = segments;
        for (int i=0; i<segments; i++){
          ground_seg[i]  = new Ground_Seg(width*1.4/segs*i, peakHeights[i], width/segs*1.4*(i+1), peakHeights[i+1]);
        }
        Translate(-(int)(width*0.1), 0);
    }
    // Left
    if(ground_type == 3){
        for (int i=0; i <peakHeights.length; i++){
          peakHeights[i] = random(pad_height, peak_height);
        }
        float segs = segments;
        for (int i=0; i<segments; i++){
          ground_seg[i]  = new Ground_Seg(peakHeights[i], height*1.4/segs*i, peakHeights[i+1], height/segs*1.4*(i+1));
        }
        Translate(0,-(int)(height*0.2));
    }
  } // End Ground Constructor
  
  int getGroundType(){
    return ground_type;
  }
  int getSegmentNum(){
    return segments;
  }
  Ground_Seg getSegment(int i){
    return ground_seg[i];
  }
  
  void Translate(float x, float y){
    for (int i=0; i<segments; i++){
          ground_seg[i].translate(x, y);
    }
  }
  
  void Draw(){
      // Draw ground
    fill(127);
    beginShape();
    // Bottom
    if(ground_type == 0){
      for (int i=0; i < segments; i++){
        vertex(ground_seg[i].x1, ground_seg[i].y1);
        vertex(ground_seg[i].x2, ground_seg[i].y2);
      }
      vertex(ground_seg[segments-1].x2, height);
      vertex(ground_seg[0].x1, height);
      endShape(CLOSE);
    }
    // Right
    if(ground_type == 1){
      for (int i=0; i < segments; i++){
        vertex(ground_seg[i].x1, ground_seg[i].y1);
        vertex(ground_seg[i].x2, ground_seg[i].y2);
      }
      vertex(width, ground_seg[segments-1].y2);
      vertex(width, ground_seg[0].y1);
      endShape(CLOSE);
    }
    // Top
    if(ground_type == 2){
      for (int i=0; i < segments; i++){
        vertex(ground_seg[i].x1, ground_seg[i].y1);
        vertex(ground_seg[i].x2, ground_seg[i].y2);
      }
      vertex(ground_seg[segments-1].x2, 0);
      vertex(ground_seg[0].x1, 0);
      endShape(CLOSE);
    }
    // Left
    if(ground_type == 3){
      for (int i=0; i < segments; i++){
        vertex(ground_seg[i].x1, ground_seg[i].y1);
        vertex(ground_seg[i].x2, ground_seg[i].y2);
      }
      vertex(0, ground_seg[segments-1].y2);
      vertex(0, ground_seg[0].y1);
      endShape(CLOSE);
    }
  } // End Draw  
}// End Ground Class
  class Ground_Seg {  
  float x1, y1, x2, y2;  
  float x, y, len, rot;
  
    Ground_Seg(float x1, float y1, float x2, float y2) {
      this.x1 = x1;
      this.y1 = y1;
      this.x2 = x2;
      this.y2 = y2;
      x = (x1+x2)/2;
      y = (y1+y2)/2;
      len = dist(x1, y1, x2, y2);
      rot = atan2((y2-y1), (x2-x1));
    }
    void translate(float x, float y){
      x1 += x;
      x2 += x;
      this.x += x;
      y1 += y;
      y2 += y;
      this.y += y;
    }
  }


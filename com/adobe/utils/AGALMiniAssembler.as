package com.adobe.utils
{
   import flash.display3D.*;
   import flash.utils.*;
   
   public class AGALMiniAssembler
   {
      protected static const REGEXP_OUTER_SPACES:RegExp = /^\s+|\s+$/g;
      
      private static var initialized:Boolean = false;
      
      private static const OPMAP:Dictionary = new Dictionary();
      
      private static const REGMAP:Dictionary = new Dictionary();
      
      private static const SAMPLEMAP:Dictionary = new Dictionary();
      
      private static const MAX_NESTING:int = 4;
      
      private static const MAX_OPCODES:int = 2048;
      
      private static const FRAGMENT:String = "fragment";
      
      private static const VERTEX:String = "vertex";
      
      private static const SAMPLER_TYPE_SHIFT:uint = 8;
      
      private static const SAMPLER_DIM_SHIFT:uint = 12;
      
      private static const SAMPLER_SPECIAL_SHIFT:uint = 16;
      
      private static const SAMPLER_REPEAT_SHIFT:uint = 20;
      
      private static const SAMPLER_MIPMAP_SHIFT:uint = 24;
      
      private static const SAMPLER_FILTER_SHIFT:uint = 28;
      
      private static const REG_WRITE:uint = 1;
      
      private static const REG_READ:uint = 2;
      
      private static const REG_FRAG:uint = 32;
      
      private static const REG_VERT:uint = 64;
      
      private static const OP_SCALAR:uint = 1;
      
      private static const OP_SPECIAL_TEX:uint = 8;
      
      private static const OP_SPECIAL_MATRIX:uint = 16;
      
      private static const OP_FRAG_ONLY:uint = 32;
      
      private static const OP_VERT_ONLY:uint = 64;
      
      private static const OP_NO_DEST:uint = 128;
      
      private static const OP_VERSION2:uint = 256;
      
      private static const OP_INCNEST:uint = 512;
      
      private static const OP_DECNEST:uint = 1024;
      
      private static const MOV:String = "mov";
      
      private static const ADD:String = "add";
      
      private static const SUB:String = "sub";
      
      private static const MUL:String = "mul";
      
      private static const DIV:String = "div";
      
      private static const RCP:String = "rcp";
      
      private static const MIN:String = "min";
      
      private static const MAX:String = "max";
      
      private static const FRC:String = "frc";
      
      private static const SQT:String = "sqt";
      
      private static const RSQ:String = "rsq";
      
      private static const POW:String = "pow";
      
      private static const LOG:String = "log";
      
      private static const EXP:String = "exp";
      
      private static const NRM:String = "nrm";
      
      private static const SIN:String = "sin";
      
      private static const COS:String = "cos";
      
      private static const CRS:String = "crs";
      
      private static const DP3:String = "dp3";
      
      private static const DP4:String = "dp4";
      
      private static const ABS:String = "abs";
      
      private static const NEG:String = "neg";
      
      private static const SAT:String = "sat";
      
      private static const M33:String = "m33";
      
      private static const M44:String = "m44";
      
      private static const M34:String = "m34";
      
      private static const DDX:String = "ddx";
      
      private static const DDY:String = "ddy";
      
      private static const IFE:String = "ife";
      
      private static const INE:String = "ine";
      
      private static const IFG:String = "ifg";
      
      private static const IFL:String = "ifl";
      
      private static const ELS:String = "els";
      
      private static const EIF:String = "eif";
      
      private static const TED:String = "ted";
      
      private static const KIL:String = "kil";
      
      private static const TEX:String = "tex";
      
      private static const SGE:String = "sge";
      
      private static const SLT:String = "slt";
      
      private static const SGN:String = "sgn";
      
      private static const SEQ:String = "seq";
      
      private static const SNE:String = "sne";
      
      private static const VA:String = "va";
      
      private static const VC:String = "vc";
      
      private static const VT:String = "vt";
      
      private static const VO:String = "vo";
      
      private static const VI:String = "vi";
      
      private static const FC:String = "fc";
      
      private static const FT:String = "ft";
      
      private static const FS:String = "fs";
      
      private static const FO:String = "fo";
      
      private static const FD:String = "fd";
      
      private static const D2:String = "2d";
      
      private static const D3:String = "3d";
      
      private static const CUBE:String = "cube";
      
      private static const MIPNEAREST:String = "mipnearest";
      
      private static const MIPLINEAR:String = "miplinear";
      
      private static const MIPNONE:String = "mipnone";
      
      private static const NOMIP:String = "nomip";
      
      private static const NEAREST:String = "nearest";
      
      private static const LINEAR:String = "linear";
      
      private static const CENTROID:String = "centroid";
      
      private static const SINGLE:String = "single";
      
      private static const IGNORESAMPLER:String = "ignoresampler";
      
      private static const REPEAT:String = "repeat";
      
      private static const WRAP:String = "wrap";
      
      private static const CLAMP:String = "clamp";
      
      private static const RGBA:String = "rgba";
      
      private static const DXT1:String = "dxt1";
      
      private static const DXT5:String = "dxt5";
      
      private static const VIDEO:String = "video";
      
      private var _agalcode:ByteArray = null;
      
      private var _error:String = "";
      
      private var debugEnabled:Boolean = false;
      
      public var verbose:Boolean = false;
      
      public function AGALMiniAssembler(param1:Boolean = false)
      {
         super();
         this.debugEnabled = param1;
         if(!initialized)
         {
            init();
         }
      }
      
      private static function init() : void
      {
         initialized = true;
         OPMAP[MOV] = new OpCode(MOV,2,0,0);
         OPMAP[ADD] = new OpCode(ADD,3,1,0);
         OPMAP[SUB] = new OpCode(SUB,3,2,0);
         OPMAP[MUL] = new OpCode(MUL,3,3,0);
         OPMAP[DIV] = new OpCode(DIV,3,4,0);
         OPMAP[RCP] = new OpCode(RCP,2,5,0);
         OPMAP[MIN] = new OpCode(MIN,3,6,0);
         OPMAP[MAX] = new OpCode(MAX,3,7,0);
         OPMAP[FRC] = new OpCode(FRC,2,8,0);
         OPMAP[SQT] = new OpCode(SQT,2,9,0);
         OPMAP[RSQ] = new OpCode(RSQ,2,10,0);
         OPMAP[POW] = new OpCode(POW,3,11,0);
         OPMAP[LOG] = new OpCode(LOG,2,12,0);
         OPMAP[EXP] = new OpCode(EXP,2,13,0);
         OPMAP[NRM] = new OpCode(NRM,2,14,0);
         OPMAP[SIN] = new OpCode(SIN,2,15,0);
         OPMAP[COS] = new OpCode(COS,2,16,0);
         OPMAP[CRS] = new OpCode(CRS,3,17,0);
         OPMAP[DP3] = new OpCode(DP3,3,18,0);
         OPMAP[DP4] = new OpCode(DP4,3,19,0);
         OPMAP[ABS] = new OpCode(ABS,2,20,0);
         OPMAP[NEG] = new OpCode(NEG,2,21,0);
         OPMAP[SAT] = new OpCode(SAT,2,22,0);
         OPMAP[M33] = new OpCode(M33,3,23,OP_SPECIAL_MATRIX);
         OPMAP[M44] = new OpCode(M44,3,24,OP_SPECIAL_MATRIX);
         OPMAP[M34] = new OpCode(M34,3,25,OP_SPECIAL_MATRIX);
         OPMAP[DDX] = new OpCode(DDX,2,26,OP_VERSION2 | OP_FRAG_ONLY);
         OPMAP[DDY] = new OpCode(DDY,2,27,OP_VERSION2 | OP_FRAG_ONLY);
         OPMAP[IFE] = new OpCode(IFE,2,28,OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
         OPMAP[INE] = new OpCode(INE,2,29,OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
         OPMAP[IFG] = new OpCode(IFG,2,30,OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
         OPMAP[IFL] = new OpCode(IFL,2,31,OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR);
         OPMAP[ELS] = new OpCode(ELS,0,32,OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_DECNEST | OP_SCALAR);
         OPMAP[EIF] = new OpCode(EIF,0,33,OP_NO_DEST | OP_VERSION2 | OP_DECNEST | OP_SCALAR);
         OPMAP[TED] = new OpCode(TED,3,38,OP_FRAG_ONLY | OP_SPECIAL_TEX | OP_VERSION2);
         OPMAP[KIL] = new OpCode(KIL,1,39,OP_NO_DEST | OP_FRAG_ONLY);
         OPMAP[TEX] = new OpCode(TEX,3,40,OP_FRAG_ONLY | OP_SPECIAL_TEX);
         OPMAP[SGE] = new OpCode(SGE,3,41,0);
         OPMAP[SLT] = new OpCode(SLT,3,42,0);
         OPMAP[SGN] = new OpCode(SGN,2,43,0);
         OPMAP[SEQ] = new OpCode(SEQ,3,44,0);
         OPMAP[SNE] = new OpCode(SNE,3,45,0);
         SAMPLEMAP[RGBA] = new Sampler(RGBA,SAMPLER_TYPE_SHIFT,0);
         SAMPLEMAP[DXT1] = new Sampler(DXT1,SAMPLER_TYPE_SHIFT,1);
         SAMPLEMAP[DXT5] = new Sampler(DXT5,SAMPLER_TYPE_SHIFT,2);
         SAMPLEMAP[VIDEO] = new Sampler(VIDEO,SAMPLER_TYPE_SHIFT,3);
         SAMPLEMAP[D2] = new Sampler(D2,SAMPLER_DIM_SHIFT,0);
         SAMPLEMAP[D3] = new Sampler(D3,SAMPLER_DIM_SHIFT,2);
         SAMPLEMAP[CUBE] = new Sampler(CUBE,SAMPLER_DIM_SHIFT,1);
         SAMPLEMAP[MIPNEAREST] = new Sampler(MIPNEAREST,SAMPLER_MIPMAP_SHIFT,1);
         SAMPLEMAP[MIPLINEAR] = new Sampler(MIPLINEAR,SAMPLER_MIPMAP_SHIFT,2);
         SAMPLEMAP[MIPNONE] = new Sampler(MIPNONE,SAMPLER_MIPMAP_SHIFT,0);
         SAMPLEMAP[NOMIP] = new Sampler(NOMIP,SAMPLER_MIPMAP_SHIFT,0);
         SAMPLEMAP[NEAREST] = new Sampler(NEAREST,SAMPLER_FILTER_SHIFT,0);
         SAMPLEMAP[LINEAR] = new Sampler(LINEAR,SAMPLER_FILTER_SHIFT,1);
         SAMPLEMAP[CENTROID] = new Sampler(CENTROID,SAMPLER_SPECIAL_SHIFT,1 << 0);
         SAMPLEMAP[SINGLE] = new Sampler(SINGLE,SAMPLER_SPECIAL_SHIFT,1 << 1);
         SAMPLEMAP[IGNORESAMPLER] = new Sampler(IGNORESAMPLER,SAMPLER_SPECIAL_SHIFT,1 << 2);
         SAMPLEMAP[REPEAT] = new Sampler(REPEAT,SAMPLER_REPEAT_SHIFT,1);
         SAMPLEMAP[WRAP] = new Sampler(WRAP,SAMPLER_REPEAT_SHIFT,1);
         SAMPLEMAP[CLAMP] = new Sampler(CLAMP,SAMPLER_REPEAT_SHIFT,0);
      }
      
      public function get error() : String
      {
         return this._error;
      }
      
      public function get agalcode() : ByteArray
      {
         return this._agalcode;
      }
      
      public function assemble2(param1:Context3D, param2:uint, param3:String, param4:String) : Program3D
      {
         var _loc5_:ByteArray = this.assemble(VERTEX,param3,param2);
         var _loc6_:ByteArray = this.assemble(FRAGMENT,param4,param2);
         var _loc7_:Program3D = param1.createProgram();
         _loc7_.upload(_loc5_,_loc6_);
         return _loc7_;
      }
      
      public function assemble(param1:String, param2:String, param3:uint = 1, param4:Boolean = false) : ByteArray
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:OpCode = null;
         var _loc12_:Array = null;
         var _loc13_:Boolean = false;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:int = 0;
         var _loc17_:Boolean = false;
         var _loc18_:Array = null;
         var _loc19_:Array = null;
         var _loc20_:Register = null;
         var _loc21_:Array = null;
         var _loc22_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:Array = null;
         var _loc25_:Boolean = false;
         var _loc26_:Boolean = false;
         var _loc27_:uint = 0;
         var _loc28_:uint = 0;
         var _loc29_:int = 0;
         var _loc30_:uint = 0;
         var _loc31_:uint = 0;
         var _loc32_:int = 0;
         var _loc33_:Array = null;
         var _loc34_:Register = null;
         var _loc35_:Array = null;
         var _loc36_:Array = null;
         var _loc37_:uint = 0;
         var _loc38_:uint = 0;
         var _loc39_:Number = Number(NaN);
         var _loc40_:Sampler = null;
         var _loc41_:* = null;
         var _loc42_:uint = 0;
         var _loc43_:uint = 0;
         var _loc44_:String = null;
         var _loc45_:uint = uint(getTimer());
         this._agalcode = new ByteArray();
         this._error = "";
         var _loc46_:Boolean = false;
         if(param1 == FRAGMENT)
         {
            _loc46_ = true;
         }
         else if(param1 != VERTEX)
         {
            this._error = "ERROR: mode needs to be \"" + FRAGMENT + "\" or \"" + VERTEX + "\" but is \"" + param1 + "\".";
         }
         this.agalcode.endian = Endian.LITTLE_ENDIAN;
         this.agalcode.writeByte(160);
         this.agalcode.writeUnsignedInt(param3);
         this.agalcode.writeByte(161);
         this.agalcode.writeByte(_loc46_ ? 1 : 0);
         this.initregmap(param3,param4);
         var _loc47_:Array = param2.replace(/[\f\n\r\v]+/g,"\n").split("\n");
         var _loc48_:int = 0;
         var _loc49_:int = 0;
         var _loc50_:int = int(_loc47_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc50_ && this._error == "")
         {
            _loc6_ = new String(_loc47_[_loc5_]);
            _loc6_ = _loc6_.replace(REGEXP_OUTER_SPACES,"");
            _loc7_ = int(_loc6_.search("//"));
            if(_loc7_ != -1)
            {
               _loc6_ = _loc6_.slice(0,_loc7_);
            }
            _loc8_ = int(_loc6_.search(/<.*>/g));
            if(_loc8_ != -1)
            {
               _loc9_ = _loc6_.slice(_loc8_).match(/([\w\.\-\+]+)/gi);
               _loc6_ = _loc6_.slice(0,_loc8_);
            }
            _loc10_ = _loc6_.match(/^\w{3}/ig);
            if(!_loc10_)
            {
               if(_loc6_.length >= 3)
               {
                  trace("warning: bad line " + _loc5_ + ": " + _loc47_[_loc5_]);
               }
            }
            else
            {
               _loc11_ = OPMAP[_loc10_[0]];
               if(this.debugEnabled)
               {
                  trace(_loc11_);
               }
               if(_loc11_ == null)
               {
                  if(_loc6_.length >= 3)
                  {
                     trace("warning: bad line " + _loc5_ + ": " + _loc47_[_loc5_]);
                  }
               }
               else
               {
                  _loc6_ = _loc6_.slice(_loc6_.search(_loc11_.name) + _loc11_.name.length);
                  if(Boolean(_loc11_.flags & OP_VERSION2) && param3 < 2)
                  {
                     this._error = "error: opcode requires version 2.";
                     break;
                  }
                  if(Boolean(_loc11_.flags & OP_VERT_ONLY) && _loc46_)
                  {
                     this._error = "error: opcode is only allowed in vertex programs.";
                     break;
                  }
                  if(Boolean(_loc11_.flags & OP_FRAG_ONLY) && !_loc46_)
                  {
                     this._error = "error: opcode is only allowed in fragment programs.";
                     break;
                  }
                  if(this.verbose)
                  {
                     trace("emit opcode=" + _loc11_);
                  }
                  this.agalcode.writeUnsignedInt(_loc11_.emitCode);
                  _loc49_++;
                  if(_loc49_ > MAX_OPCODES)
                  {
                     this._error = "error: too many opcodes. maximum is " + MAX_OPCODES + ".";
                     break;
                  }
                  _loc12_ = _loc6_.match(/vc\[([vof][acostdip]?)(\d*)?(\.[xyzw](\+\d{1,3})?)?\](\.[xyzw]{1,4})?|([vof][acostdip]?)(\d*)?(\.[xyzw]{1,4})?/gi);
                  if(!_loc12_ || _loc12_.length != _loc11_.numRegister)
                  {
                     this._error = "error: wrong number of operands. found " + _loc12_.length + " but expected " + _loc11_.numRegister + ".";
                     break;
                  }
                  _loc13_ = false;
                  _loc14_ = uint(64 + 64 + 32);
                  _loc15_ = _loc12_.length;
                  _loc16_ = 0;
                  while(_loc16_ < _loc15_)
                  {
                     _loc17_ = false;
                     _loc18_ = _loc12_[_loc16_].match(/\[.*\]/ig);
                     if(Boolean(_loc18_) && _loc18_.length > 0)
                     {
                        _loc12_[_loc16_] = _loc12_[_loc16_].replace(_loc18_[0],"0");
                        if(this.verbose)
                        {
                           trace("IS REL");
                        }
                        _loc17_ = true;
                     }
                     _loc19_ = _loc12_[_loc16_].match(/^\b[A-Za-z]{1,2}/ig);
                     if(!_loc19_)
                     {
                        this._error = "error: could not parse operand " + _loc16_ + " (" + _loc12_[_loc16_] + ").";
                        _loc13_ = true;
                        break;
                     }
                     _loc20_ = REGMAP[_loc19_[0]];
                     if(this.debugEnabled)
                     {
                        trace(_loc20_);
                     }
                     if(_loc20_ == null)
                     {
                        this._error = "error: could not find register name for operand " + _loc16_ + " (" + _loc12_[_loc16_] + ").";
                        _loc13_ = true;
                        break;
                     }
                     if(_loc46_)
                     {
                        if(!(_loc20_.flags & REG_FRAG))
                        {
                           this._error = "error: register operand " + _loc16_ + " (" + _loc12_[_loc16_] + ") only allowed in vertex programs.";
                           _loc13_ = true;
                           break;
                        }
                        if(_loc17_)
                        {
                           this._error = "error: register operand " + _loc16_ + " (" + _loc12_[_loc16_] + ") relative adressing not allowed in fragment programs.";
                           _loc13_ = true;
                           break;
                        }
                     }
                     else if(!(_loc20_.flags & REG_VERT))
                     {
                        this._error = "error: register operand " + _loc16_ + " (" + _loc12_[_loc16_] + ") only allowed in fragment programs.";
                        _loc13_ = true;
                        break;
                     }
                     _loc12_[_loc16_] = _loc12_[_loc16_].slice(_loc12_[_loc16_].search(_loc20_.name) + _loc20_.name.length);
                     _loc21_ = _loc17_ ? _loc18_[0].match(/\d+/) : _loc12_[_loc16_].match(/\d+/);
                     _loc22_ = 0;
                     if(Boolean(_loc21_))
                     {
                        _loc22_ = uint(_loc21_[0]);
                     }
                     if(_loc20_.range < _loc22_)
                     {
                        this._error = "error: register operand " + _loc16_ + " (" + _loc12_[_loc16_] + ") index exceeds limit of " + (_loc20_.range + 1) + ".";
                        _loc13_ = true;
                        break;
                     }
                     _loc23_ = 0;
                     _loc24_ = _loc12_[_loc16_].match(/(\.[xyzw]{1,4})/);
                     _loc25_ = _loc16_ == 0 && !(_loc11_.flags & OP_NO_DEST);
                     _loc26_ = _loc16_ == 2 && Boolean(_loc11_.flags & OP_SPECIAL_TEX);
                     _loc27_ = 0;
                     _loc28_ = 0;
                     _loc29_ = 0;
                     if(_loc25_ && _loc17_)
                     {
                        this._error = "error: relative can not be destination";
                        _loc13_ = true;
                        break;
                     }
                     if(Boolean(_loc24_))
                     {
                        _loc23_ = 0;
                        _loc31_ = uint(_loc24_[0].length);
                        _loc32_ = 1;
                        while(_loc32_ < _loc31_)
                        {
                           _loc30_ = _loc24_[0].charCodeAt(_loc32_) - "x".charCodeAt(0);
                           if(_loc30_ > 2)
                           {
                              _loc30_ = 3;
                           }
                           if(_loc25_)
                           {
                              _loc23_ |= 1 << _loc30_;
                           }
                           else
                           {
                              _loc23_ |= _loc30_ << (_loc32_ - 1 << 1);
                           }
                           _loc32_++;
                        }
                        if(!_loc25_)
                        {
                           while(_loc32_ <= 4)
                           {
                              _loc23_ |= _loc30_ << (_loc32_ - 1 << 1);
                              _loc32_++;
                           }
                        }
                     }
                     else
                     {
                        _loc23_ = _loc25_ ? 15 : 228;
                     }
                     if(_loc17_)
                     {
                        _loc33_ = _loc18_[0].match(/[A-Za-z]{1,2}/ig);
                        _loc34_ = REGMAP[_loc33_[0]];
                        if(_loc34_ == null)
                        {
                           this._error = "error: bad index register";
                           _loc13_ = true;
                           break;
                        }
                        _loc27_ = _loc34_.emitCode;
                        _loc35_ = _loc18_[0].match(/(\.[xyzw]{1,1})/);
                        if(_loc35_.length == 0)
                        {
                           this._error = "error: bad index register select";
                           _loc13_ = true;
                           break;
                        }
                        _loc28_ = _loc35_[0].charCodeAt(1) - "x".charCodeAt(0);
                        if(_loc28_ > 2)
                        {
                           _loc28_ = 3;
                        }
                        _loc36_ = _loc18_[0].match(/\+\d{1,3}/ig);
                        if(_loc36_.length > 0)
                        {
                           _loc29_ = int(_loc36_[0]);
                        }
                        if(_loc29_ < 0 || _loc29_ > 255)
                        {
                           this._error = "error: index offset " + _loc29_ + " out of bounds. [0..255]";
                           _loc13_ = true;
                           break;
                        }
                        if(this.verbose)
                        {
                           trace("RELATIVE: type=" + _loc27_ + "==" + _loc33_[0] + " sel=" + _loc28_ + "==" + _loc35_[0] + " idx=" + _loc22_ + " offset=" + _loc29_);
                        }
                     }
                     if(this.verbose)
                     {
                        trace("  emit argcode=" + _loc20_ + "[" + _loc22_ + "][" + _loc23_ + "]");
                     }
                     if(_loc25_)
                     {
                        this.agalcode.writeShort(_loc22_);
                        this.agalcode.writeByte(_loc23_);
                        this.agalcode.writeByte(_loc20_.emitCode);
                        _loc14_ -= 32;
                     }
                     else if(_loc26_)
                     {
                        if(this.verbose)
                        {
                           trace("  emit sampler");
                        }
                        _loc37_ = 5;
                        _loc38_ = _loc9_ == null ? 0 : _loc9_.length;
                        _loc39_ = 0;
                        _loc32_ = 0;
                        while(_loc32_ < _loc38_)
                        {
                           if(this.verbose)
                           {
                              trace("    opt: " + _loc9_[_loc32_]);
                           }
                           _loc40_ = SAMPLEMAP[_loc9_[_loc32_]];
                           if(_loc40_ == null)
                           {
                              _loc39_ = Number(_loc9_[_loc32_]);
                              if(this.verbose)
                              {
                                 trace("    bias: " + _loc39_);
                              }
                           }
                           else
                           {
                              if(_loc40_.flag != SAMPLER_SPECIAL_SHIFT)
                              {
                                 _loc37_ &= ~(15 << _loc40_.flag);
                              }
                              _loc37_ |= uint(_loc40_.mask) << uint(_loc40_.flag);
                           }
                           _loc32_++;
                        }
                        this.agalcode.writeShort(_loc22_);
                        this.agalcode.writeByte(int(_loc39_ * 8));
                        this.agalcode.writeByte(0);
                        this.agalcode.writeUnsignedInt(_loc37_);
                        if(this.verbose)
                        {
                           trace("    bits: " + (_loc37_ - 5));
                        }
                        _loc14_ -= 64;
                     }
                     else
                     {
                        if(_loc16_ == 0)
                        {
                           this.agalcode.writeUnsignedInt(0);
                           _loc14_ -= 32;
                        }
                        this.agalcode.writeShort(_loc22_);
                        this.agalcode.writeByte(_loc29_);
                        this.agalcode.writeByte(_loc23_);
                        this.agalcode.writeByte(_loc20_.emitCode);
                        this.agalcode.writeByte(_loc27_);
                        this.agalcode.writeShort(_loc17_ ? _loc28_ | 1 << 15 : 0);
                        _loc14_ -= 64;
                     }
                     _loc16_++;
                  }
                  _loc16_ = 0;
                  while(_loc16_ < _loc14_)
                  {
                     this.agalcode.writeByte(0);
                     _loc16_ += 8;
                  }
                  if(_loc13_)
                  {
                     break;
                  }
               }
            }
            _loc5_++;
         }
         if(this._error != "")
         {
            this._error += "\n  at line " + _loc5_ + " " + _loc47_[_loc5_];
            this.agalcode.length = 0;
            trace(this._error);
         }
         if(this.debugEnabled)
         {
            _loc41_ = "generated bytecode:";
            _loc42_ = this.agalcode.length;
            _loc43_ = 0;
            while(_loc43_ < _loc42_)
            {
               if(!(_loc43_ % 16))
               {
                  _loc41_ += "\n";
               }
               if(!(_loc43_ % 4))
               {
                  _loc41_ += " ";
               }
               _loc44_ = this.agalcode[_loc43_].toString(16);
               if(_loc44_.length < 2)
               {
                  _loc44_ = "0" + _loc44_;
               }
               _loc41_ += _loc44_;
               _loc43_++;
            }
            trace(_loc41_);
         }
         if(this.verbose)
         {
            trace("AGALMiniAssembler.assemble time: " + (getTimer() - _loc45_) / 1000 + "s");
         }
         return this.agalcode;
      }
      
      private function initregmap(param1:uint, param2:Boolean) : void
      {
         REGMAP[VA] = new Register(VA,"vertex attribute",0,param2 ? 1024 : 7,REG_VERT | REG_READ);
         REGMAP[VC] = new Register(VC,"vertex constant",1,param2 ? 1024 : (param1 == 1 ? 127 : 250),REG_VERT | REG_READ);
         REGMAP[VT] = new Register(VT,"vertex temporary",2,param2 ? 1024 : (param1 == 1 ? 7 : 27),REG_VERT | REG_WRITE | REG_READ);
         REGMAP[VO] = new Register(VO,"vertex output",3,param2 ? 1024 : 0,REG_VERT | REG_WRITE);
         REGMAP[VI] = new Register(VI,"varying",4,param2 ? 1024 : (param1 == 1 ? 7 : 11),REG_VERT | REG_FRAG | REG_READ | REG_WRITE);
         REGMAP[FC] = new Register(FC,"fragment constant",1,param2 ? 1024 : (param1 == 1 ? 27 : 63),REG_FRAG | REG_READ);
         REGMAP[FT] = new Register(FT,"fragment temporary",2,param2 ? 1024 : (param1 == 1 ? 7 : 27),REG_FRAG | REG_WRITE | REG_READ);
         REGMAP[FS] = new Register(FS,"texture sampler",5,param2 ? 1024 : 7,REG_FRAG | REG_READ);
         REGMAP[FO] = new Register(FO,"fragment output",3,param2 ? 1024 : (param1 == 1 ? 0 : 3),REG_FRAG | REG_WRITE);
         REGMAP[FD] = new Register(FD,"fragment depth output",6,param2 ? 1024 : (param1 == 1 ? uint(-1) : 0),REG_FRAG | REG_WRITE);
         REGMAP["op"] = REGMAP[VO];
         REGMAP["i"] = REGMAP[VI];
         REGMAP["v"] = REGMAP[VI];
         REGMAP["oc"] = REGMAP[FO];
         REGMAP["od"] = REGMAP[FD];
         REGMAP["fi"] = REGMAP[VI];
      }
   }
}

class OpCode
{
   private var _emitCode:uint;
   
   private var _flags:uint;
   
   private var _name:String;
   
   private var _numRegister:uint;
   
   public function OpCode(param1:String, param2:uint, param3:uint, param4:uint)
   {
      super();
      this._name = param1;
      this._numRegister = param2;
      this._emitCode = param3;
      this._flags = param4;
   }
   
   public function get emitCode() : uint
   {
      return this._emitCode;
   }
   
   public function get flags() : uint
   {
      return this._flags;
   }
   
   public function get name() : String
   {
      return this._name;
   }
   
   public function get numRegister() : uint
   {
      return this._numRegister;
   }
   
   public function toString() : String
   {
      return "[OpCode name=\"" + this._name + "\", numRegister=" + this._numRegister + ", emitCode=" + this._emitCode + ", flags=" + this._flags + "]";
   }
}

class Register
{
   private var _emitCode:uint;
   
   private var _name:String;
   
   private var _longName:String;
   
   private var _flags:uint;
   
   private var _range:uint;
   
   public function Register(param1:String, param2:String, param3:uint, param4:uint, param5:uint)
   {
      super();
      this._name = param1;
      this._longName = param2;
      this._emitCode = param3;
      this._range = param4;
      this._flags = param5;
   }
   
   public function get emitCode() : uint
   {
      return this._emitCode;
   }
   
   public function get longName() : String
   {
      return this._longName;
   }
   
   public function get name() : String
   {
      return this._name;
   }
   
   public function get flags() : uint
   {
      return this._flags;
   }
   
   public function get range() : uint
   {
      return this._range;
   }
   
   public function toString() : String
   {
      return "[Register name=\"" + this._name + "\", longName=\"" + this._longName + "\", emitCode=" + this._emitCode + ", range=" + this._range + ", flags=" + this._flags + "]";
   }
}

class Sampler
{
   private var _flag:uint;
   
   private var _mask:uint;
   
   private var _name:String;
   
   public function Sampler(param1:String, param2:uint, param3:uint)
   {
      super();
      this._name = param1;
      this._flag = param2;
      this._mask = param3;
   }
   
   public function get flag() : uint
   {
      return this._flag;
   }
   
   public function get mask() : uint
   {
      return this._mask;
   }
   
   public function get name() : String
   {
      return this._name;
   }
   
   public function toString() : String
   {
      return "[Sampler name=\"" + this._name + "\", flag=\"" + this._flag + "\", mask=" + this.mask + "]";
   }
}

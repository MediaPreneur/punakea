FasdUAS 1.101.10   ��   ��    k             l     ��  ��    ` Z Copyright (c) 2006-2011 nudge:nudge (Johannes Hoffart & Daniel B�r). All rights reserved.     � 	 	 �   C o p y r i g h t   ( c )   2 0 0 6 - 2 0 1 1   n u d g e : n u d g e   ( J o h a n n e s   H o f f a r t   &   D a n i e l   B � r ) .   A l l   r i g h t s   r e s e r v e d .   
  
 l     ��  ��           �           l     ��  ��    S M Permission is hereby granted, free of charge, to any person obtaining a copy     �   �   P e r m i s s i o n   i s   h e r e b y   g r a n t e d ,   f r e e   o f   c h a r g e ,   t o   a n y   p e r s o n   o b t a i n i n g   a   c o p y      l     ��  ��    T N of this software and associated documentation files (the "Software"), to deal     �   �   o f   t h i s   s o f t w a r e   a n d   a s s o c i a t e d   d o c u m e n t a t i o n   f i l e s   ( t h e   " S o f t w a r e " ) ,   t o   d e a l      l     ��  ��    S M in the Software without restriction, including without limitation the rights     �   �   i n   t h e   S o f t w a r e   w i t h o u t   r e s t r i c t i o n ,   i n c l u d i n g   w i t h o u t   l i m i t a t i o n   t h e   r i g h t s      l     ��   !��     P J to use, copy, modify, merge, publish, distribute, sublicense, and/or sell    ! � " " �   t o   u s e ,   c o p y ,   m o d i f y ,   m e r g e ,   p u b l i s h ,   d i s t r i b u t e ,   s u b l i c e n s e ,   a n d / o r   s e l l   # $ # l     �� % &��   % L F copies of the Software, and to permit persons to whom the Software is    & � ' ' �   c o p i e s   o f   t h e   S o f t w a r e ,   a n d   t o   p e r m i t   p e r s o n s   t o   w h o m   t h e   S o f t w a r e   i s $  ( ) ( l     �� * +��   * ? 9 furnished to do so, subject to the following conditions:    + � , , r   f u r n i s h e d   t o   d o   s o ,   s u b j e c t   t o   t h e   f o l l o w i n g   c o n d i t i o n s : )  - . - l     �� / 0��   /       0 � 1 1    .  2 3 2 l     �� 4 5��   4 Q K The above copyright notice and this permission notice shall be included in    5 � 6 6 �   T h e   a b o v e   c o p y r i g h t   n o t i c e   a n d   t h i s   p e r m i s s i o n   n o t i c e   s h a l l   b e   i n c l u d e d   i n 3  7 8 7 l     �� 9 :��   9 : 4 all copies or substantial portions of the Software.    : � ; ; h   a l l   c o p i e s   o r   s u b s t a n t i a l   p o r t i o n s   o f   t h e   S o f t w a r e . 8  < = < l     �� > ?��   >       ? � @ @    =  A B A l     �� C D��   C Q K THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    D � E E �   T H E   S O F T W A R E   I S   P R O V I D E D   " A S   I S " ,   W I T H O U T   W A R R A N T Y   O F   A N Y   K I N D ,   E X P R E S S   O R B  F G F l     �� H I��   H O I IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    I � J J �   I M P L I E D ,   I N C L U D I N G   B U T   N O T   L I M I T E D   T O   T H E   W A R R A N T I E S   O F   M E R C H A N T A B I L I T Y , G  K L K l     �� M N��   M R L FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    N � O O �   F I T N E S S   F O R   A   P A R T I C U L A R   P U R P O S E   A N D   N O N I N F R I N G E M E N T .   I N   N O   E V E N T   S H A L L   T H E L  P Q P l     �� R S��   R M G AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER    S � T T �   A U T H O R S   O R   C O P Y R I G H T   H O L D E R S   B E   L I A B L E   F O R   A N Y   C L A I M ,   D A M A G E S   O R   O T H E R Q  U V U l     �� W X��   W T N LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,    X � Y Y �   L I A B I L I T Y ,   W H E T H E R   I N   A N   A C T I O N   O F   C O N T R A C T ,   T O R T   O R   O T H E R W I S E ,   A R I S I N G   F R O M , V  Z [ Z l     �� \ ]��   \ P J OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN    ] � ^ ^ �   O U T   O F   O R   I N   C O N N E C T I O N   W I T H   T H E   S O F T W A R E   O R   T H E   U S E   O R   O T H E R   D E A L I N G S   I N [  _ ` _ l     �� a b��   a   THE SOFTWARE.    b � c c    T H E   S O F T W A R E . `  d e d l     ��������  ��  ��   e  f g f l   a h���� h O    a i j i k   ` k k  l m l l   ��������  ��  ��   m  n o n r     p q p 6    r s r n    
 t u t 1    
��
�� 
pnam u 4   �� v
�� 
pcap v m    ����  s =    w x w 1    ��
�� 
pisf x m    ��
�� boovtrue q o      ���� 0 frontapp frontApp o  y z y l   ��������  ��  ��   z  { | { l   �� } ~��   }   Handle file selection    ~ �   ,   H a n d l e   f i l e   s e l e c t i o n |  � � � r     � � � J    ����   � o      ���� 0 thefiles theFiles �  � � � l   ��������  ��  ��   �  � � � Z    � � � ��� � =    � � � o    ���� 0 frontapp frontApp � m     � � � � �  F i n d e r � O   ! I � � � k   % H � �  � � � r   % * � � � l  % ( ����� � 1   % (��
�� 
sele��  ��   � o      ���� 0 selecteditems selectedItems �  ��� � X   + H ��� � � s   ; C � � � l  ; @ ����� � n   ; @ � � � 1   > @��
�� 
psxp � l  ; > ����� � c   ; > � � � o   ; <���� 0 theitem theItem � m   < =��
�� 
alis��  ��  ��  ��   � l      ����� � n       � � �  ;   A B � l  @ A ����� � o   @ A���� 0 thefiles theFiles��  ��  ��  ��  �� 0 theitem theItem � o   . /���� 0 selecteditems selectedItems��   � m   ! " � ��                                                                                  MACS  alis    Z  mac                        �#�H+   8��
Finder.app                                                      9:
�(��        ����  	                CoreServices    �g      �(��     8�� 8�� 8��  -mac:System: Library: CoreServices: Finder.app    
 F i n d e r . a p p    m a c  &System/Library/CoreServices/Finder.app  / ��   �  � � � =  L Q � � � o   L M���� 0 frontapp frontApp � m   M P � � � � �  P u n a k e a �  � � � O   T b � � � r   Z a � � � l  Z _ ����� � 1   Z _��
�� 
seLE��  ��   � o      ���� 0 thefiles theFiles � m   T W � ��                                                                                  NNPA  alis    6  mac                        �#�H+   8��Punakea.app                                                     ʿ���a        ����  	                Applications    �g      �ձA     8��  mac:Applications: Punakea.app     P u n a k e a . a p p    m a c  Applications/Punakea.app  / ��   �  � � � =  e j � � � o   e f���� 0 frontapp frontApp � m   f i � � � � �  P a t h   F i n d e r �  ��� � O   m � � � � k   s � � �  � � � r   s z � � � l  s x ����� � 1   s x��
�� 
slcT��  ��   � o      ���� 0 selecteditems selectedItems �  ��� � X   { � ��� � � s   � � � � � l  � � ����� � n   � � � � � 1   � ���
�� 
pthP � o   � ����� 0 theitem theItem��  ��   � l      ����� � n       � � �  ;   � � � l  � � ����� � o   � ����� 0 thefiles theFiles��  ��  ��  ��  �� 0 theitem theItem � o   ~ ���� 0 selecteditems selectedItems��   � m   m p � ��                                                                                  PFdR  alis    F  mac                        �#�H+   8��Path Finder.app                                                 �t���,        ����  	                Applications    �g      ���     8��  !mac:Applications: Path Finder.app      P a t h   F i n d e r . a p p    m a c  Applications/Path Finder.app  / ��  ��  ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Handle URL selection    � � � � *   H a n d l e   U R L   s e l e c t i o n �  � � � l  � � � � � � r   � � � � � m   � � � � � � �   � o      ���� 0 theurl theURL �   Declare variable    � � � � "   D e c l a r e   v a r i a b l e �  � � � l  � ���������  ��  ��   �  � � � Z   �N � � ��� � =  � � � � � o   � ����� 0 frontapp frontApp � m   � � � � � � �  f i r e f o x - b i n � O   � � � � � k   � � � �  � � � l  � ��� � ���   � ( " Title is �class pTit� of window 1    � � � � D   T i t l e   i s   � c l a s s   p T i t �   o f   w i n d o w   1 �  ��� � r   � � � � � J   � � � �  � � � c   � � � � � n   � � �  � m   � ���
�� 
curl  4   � ���
�� 
cwin m   � �����  � m   � ���
�� 
TEXT � �� m   � � �  ��   � o      ���� 0 theurl theURL��   � m   � ��                                                                                  MOZB  alis    6  mac                        �#�H+   8��Firefox.app                                                     ����        ����  	                Applications    �g      ����     8��  mac:Applications: Firefox.app     F i r e f o x . a p p    m a c  Applications/Firefox.app  / ��   �  =  � �	 o   � ����� 0 frontapp frontApp	 m   � �

 � 
 O p e r a  O   � � r   � � I  � �����
�� .WWW!WNFO****      � **** 4   � ���
�� 
cwin m   � ����� ��   o      ���� 0 theurl theURL m   � ��                                                                                  OPRA  alis    .  mac                        �#�H+   8��	Opera.app                                                       �}ȵ�d        ����  	                Applications    �g      ȵ�D     8��  mac:Applications: Opera.app    	 O p e r a . a p p    m a c  Applications/Opera.app  / ��    =  � � o   � ����� 0 frontapp frontApp m   � � �  C a m i n o  O   �  r   �  J   �!! "#" n   �$%$ 1  ��
�� 
pURL% n   �&'& 1  ��
�� 
pCTb' 4  ���(
�� 
BWin( m  ���� # )��) n  *+* 1  ��
�� 
pTtl+ n  ,-, 1  ��
�� 
pCTb- 4 ��.
�� 
BWin. m  ���� ��    o      ���� 0 theurl theURL m   � �//�                                                                                  MOZC  alis    2  mac                        �#�H+   8��
Camino.app                                                       ��ɬ��        ����  	                Applications    �g      ɬ��     8��  mac:Applications: Camino.app   
 C a m i n o . a p p    m a c  Applications/Camino.app   / ��   010 = #(232 o  #$���� 0 frontapp frontApp3 m  $'44 �55  S a f a r i1 6��6 O  +J787 r  1I9:9 J  1E;; <=< n  1;>?> 1  7;��
�� 
pURL? 4  17�@
� 
docu@ m  56�~�~ = A�}A n  ;CBCB 1  AC�|
�| 
pnamC 4  ;A�{D
�{ 
docuD m  ?@�z�z �}  : o      �y�y 0 theurl theURL8 m  +.EE�                                                                                  sfri  alis    2  mac                        �#�H+   8��
Safari.app                                                      8����t        ����  	                Applications    �g      ��T     8��  mac:Applications: Safari.app   
 S a f a r i . a p p    m a c  Applications/Safari.app   / ��  ��  ��   � FGF l OO�x�w�v�x  �w  �v  G HIH r  OYJKJ J  OULL MNM o  OP�u�u 0 thefiles theFilesN O�tO o  PS�s�s 0 theurl theURL�t  K o      �r�r 0 results  I PQP l ZZ�q�p�o�q  �p  �o  Q RSR L  Z^TT o  Z]�n�n 0 results  S U�mU l __�l�k�j�l  �k  �j  �m   j m     VV�                                                                                  sevs  alis    v  mac                        �#�H+   8��System Events.app                                               9w� lb        ����  	                CoreServices    �g      � PB     8�� 8�� 8��  4mac:System: Library: CoreServices: System Events.app  $  S y s t e m   E v e n t s . a p p    m a c  -System/Library/CoreServices/System Events.app   / ��  ��  ��   g W�iW l     �h�g�f�h  �g  �f  �i       �eXY�e  X �d
�d .aevtoappnull  �   � ****Y �cZ�b�a[\�`
�c .aevtoappnull  �   � ****Z k    a]]  f�_�_  �b  �a  [ �^�^ 0 theitem theItem\ ,V�]�\^�[�Z�Y � ��X�W�V�U�T�S�R � ��Q � ��P�O ��N ��M�L�K
�J/�I�H�G�F4E�E�D
�] 
pcap
�\ 
pnam^  
�[ 
pisf�Z 0 frontapp frontApp�Y 0 thefiles theFiles
�X 
sele�W 0 selecteditems selectedItems
�V 
kocl
�U 
cobj
�T .corecnte****       ****
�S 
alis
�R 
psxp
�Q 
seLE
�P 
slcT
�O 
pthP�N 0 theurl theURL
�M 
cwin
�L 
curl
�K 
TEXT
�J .WWW!WNFO****      � ****
�I 
BWin
�H 
pCTb
�G 
pURL
�F 
pTtl
�E 
docu�D 0 results  �`b�^*�k/�,�[�,\Ze81E�OjvE�O��  -� %*�,E�O �[��l kh  ��&�,�6G[OY��UY S�a   a  	*a ,E�UY :�a   1a  '*a ,E�O �[��l kh  �a ,�6G[OY��UY hOa E` O�a   #a  *a k/a ,a &a lvE` UY ��a   a   *a k/j !E` UY a�a "  .a # $*a $k/a %,a &,*a $k/a %,a ',lvE` UY -�a (  $a ) *a *k/a &,*a *k/�,lvE` UY hO�_ lvE` +O_ +OPUascr  ��ޭ
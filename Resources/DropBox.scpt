FasdUAS 1.101.10   ��   ��    k             l     ��  ��    ` Z Copyright (c) 2006-2011 nudge:nudge (Johannes Hoffart & Daniel B�r). All rights reserved.     � 	 	 �   C o p y r i g h t   ( c )   2 0 0 6 - 2 0 1 1   n u d g e : n u d g e   ( J o h a n n e s   H o f f a r t   &   D a n i e l   B � r ) .   A l l   r i g h t s   r e s e r v e d .   
  
 l     ��  ��           �           l     ��  ��    S M Permission is hereby granted, free of charge, to any person obtaining a copy     �   �   P e r m i s s i o n   i s   h e r e b y   g r a n t e d ,   f r e e   o f   c h a r g e ,   t o   a n y   p e r s o n   o b t a i n i n g   a   c o p y      l     ��  ��    T N of this software and associated documentation files (the "Software"), to deal     �   �   o f   t h i s   s o f t w a r e   a n d   a s s o c i a t e d   d o c u m e n t a t i o n   f i l e s   ( t h e   " S o f t w a r e " ) ,   t o   d e a l      l     ��  ��    S M in the Software without restriction, including without limitation the rights     �   �   i n   t h e   S o f t w a r e   w i t h o u t   r e s t r i c t i o n ,   i n c l u d i n g   w i t h o u t   l i m i t a t i o n   t h e   r i g h t s      l     ��   !��     P J to use, copy, modify, merge, publish, distribute, sublicense, and/or sell    ! � " " �   t o   u s e ,   c o p y ,   m o d i f y ,   m e r g e ,   p u b l i s h ,   d i s t r i b u t e ,   s u b l i c e n s e ,   a n d / o r   s e l l   # $ # l     �� % &��   % L F copies of the Software, and to permit persons to whom the Software is    & � ' ' �   c o p i e s   o f   t h e   S o f t w a r e ,   a n d   t o   p e r m i t   p e r s o n s   t o   w h o m   t h e   S o f t w a r e   i s $  ( ) ( l     �� * +��   * ? 9 furnished to do so, subject to the following conditions:    + � , , r   f u r n i s h e d   t o   d o   s o ,   s u b j e c t   t o   t h e   f o l l o w i n g   c o n d i t i o n s : )  - . - l     �� / 0��   /       0 � 1 1    .  2 3 2 l     �� 4 5��   4 Q K The above copyright notice and this permission notice shall be included in    5 � 6 6 �   T h e   a b o v e   c o p y r i g h t   n o t i c e   a n d   t h i s   p e r m i s s i o n   n o t i c e   s h a l l   b e   i n c l u d e d   i n 3  7 8 7 l     �� 9 :��   9 : 4 all copies or substantial portions of the Software.    : � ; ; h   a l l   c o p i e s   o r   s u b s t a n t i a l   p o r t i o n s   o f   t h e   S o f t w a r e . 8  < = < l     �� > ?��   >       ? � @ @    =  A B A l     �� C D��   C Q K THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    D � E E �   T H E   S O F T W A R E   I S   P R O V I D E D   " A S   I S " ,   W I T H O U T   W A R R A N T Y   O F   A N Y   K I N D ,   E X P R E S S   O R B  F G F l     �� H I��   H O I IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    I � J J �   I M P L I E D ,   I N C L U D I N G   B U T   N O T   L I M I T E D   T O   T H E   W A R R A N T I E S   O F   M E R C H A N T A B I L I T Y , G  K L K l     �� M N��   M R L FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    N � O O �   F I T N E S S   F O R   A   P A R T I C U L A R   P U R P O S E   A N D   N O N I N F R I N G E M E N T .   I N   N O   E V E N T   S H A L L   T H E L  P Q P l     �� R S��   R M G AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER    S � T T �   A U T H O R S   O R   C O P Y R I G H T   H O L D E R S   B E   L I A B L E   F O R   A N Y   C L A I M ,   D A M A G E S   O R   O T H E R Q  U V U l     �� W X��   W T N LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,    X � Y Y �   L I A B I L I T Y ,   W H E T H E R   I N   A N   A C T I O N   O F   C O N T R A C T ,   T O R T   O R   O T H E R W I S E ,   A R I S I N G   F R O M , V  Z [ Z l     �� \ ]��   \ P J OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN    ] � ^ ^ �   O U T   O F   O R   I N   C O N N E C T I O N   W I T H   T H E   S O F T W A R E   O R   T H E   U S E   O R   O T H E R   D E A L I N G S   I N [  _ ` _ l     �� a b��   a   THE SOFTWARE.    b � c c    T H E   S O F T W A R E . `  d e d l     ��������  ��  ��   e  f g f i      h i h I     �� j k
�� .facofgetnull���     alis j o      ���� 0 dropbox DropBox k �� l��
�� 
flst l o      ���� 0 droppedfiles DroppedFiles��   i k     � m m  n o n l     ��������  ��  ��   o  p q p l     �� r s��   r ) # Initialize tags with some defaults    s � t t F   I n i t i a l i z e   t a g s   w i t h   s o m e   d e f a u l t s q  u v u r      w x w J      y y  z�� z m      { { � | |  u n t a g g e d��   x o      ���� 0 tags   v  } ~ } l   ��������  ��  ��   ~   �  l   �� � ���   � ) # Get the comment from Punakea prefs    � � � � F   G e t   t h e   c o m m e n t   f r o m   P u n a k e a   p r e f s �  � � � O    L � � � k   
 K � �  � � � Q   
 4 � ��� � k    + � �  � � � r      � � � c     � � � l    ����� � b     � � � l    ����� � c     � � � l    ����� � I   �� � �
�� .earsffdralis        afdr � 1    ��
�� 
dlib � �� ���
�� 
from � 1    ��
�� 
fldu��  ��  ��   � m    ��
�� 
TEXT��  ��   � m     � � � � � N P r e f e r e n c e s : e u . n u d g e n u d g e . p u n a k e a . p l i s t��  ��   � m    ��
�� 
alis � o      ���� 0 	plistfile 	pListFile �  ��� � r   ! + � � � n   ! ) � � � 1   ' )��
�� 
pcnt � 4   ! '�� �
�� 
plif � l  # & ����� � c   # & � � � o   # $���� 0 	plistfile 	pListFile � m   $ %��
�� 
utxt��  ��   � o      ���� 0 plist pList��   � R      ������
�� .ascrerr ****      � ****��  ��  ��   �  � � � l  5 5��������  ��  ��   �  ��� � Q   5 K � ��� � r   8 B � � � n   8 @ � � � 1   < @��
�� 
valL � n   8 < � � � 4   9 <�� �
�� 
plii � m   : ; � � � � � 0 M a n a g e F i l e s . D r o p B o x . T a g s � o   8 9���� 0 plist pList � o      ���� 0 tags   � R      ������
�� .ascrerr ****      � ****��  ��  ��  ��   � m     � ��                                                                                  sevs  alis    v  mac                        �#�H+   8��System Events.app                                               9w� lb        ����  	                CoreServices    �g      � PB     8�� 8�� 8��  4mac:System: Library: CoreServices: System Events.app  $  S y s t e m   E v e n t s . a p p    m a c  -System/Library/CoreServices/System Events.app   / ��   �  � � � l  M M��������  ��  ��   �  � � � l  M M�� � ���   � %  Write comment on dropped files    � � � � >   W r i t e   c o m m e n t   o n   d r o p p e d   f i l e s �  ��� � X   M � ��� � � k   a � � �  � � � Q   a  � ��� � k   d v � �  � � � l  d d�� � ���   � &  tell application "System Events"    � � � � @ t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s " �  � � � l  d d�� � ���   � 6 0	attach action to folder f using file scriptPath    � � � � ` 	 a t t a c h   a c t i o n   t o   f o l d e r   f   u s i n g   f i l e   s c r i p t P a t h �  � � � l  d d�� � ���   �  end tell    � � � �  e n d   t e l l �  � � � l  d d��������  ��  ��   �  ��� � O   d v � � � I  j u�� � �
�� .nnpaadtgnull���    utxt � o   j k���� 0 tags   � �� ���
�� 
to   � c   n q � � � o   n o���� 0 afile aFile � m   o p��
�� 
alis��   � m   d g � ��                                                                                  NNPA  alis    6  mac                        �#�H+   8��Punakea.app                                                     ʿ���a        ����  	                Applications    �g      �ձA     8��  mac:Applications: Punakea.app     P u n a k e a . a p p    m a c  Applications/Punakea.app  / ��  ��   � R      ������
�� .ascrerr ****      � ****��  ��  ��   �  ��� � l  � ���������  ��  ��  ��  �� 0 afile aFile � o   P Q���� 0 droppedfiles DroppedFiles��   g  ��� � l     ��������  ��  ��  ��       �� � ���   � ��
�� .facofgetnull���     alis � �� i���� � ���
�� .facofgetnull���     alis�� 0 dropbox DropBox�� ������
�� 
flst�� 0 droppedfiles DroppedFiles��   � �������������� 0 dropbox DropBox�� 0 droppedfiles DroppedFiles�� 0 tags  �� 0 	plistfile 	pListFile�� 0 plist pList�� 0 afile aFile �  { ����������� ���~�}�|�{�z�y ��x�w�v�u ��t�s
�� 
dlib
�� 
from
�� 
fldu
�� .earsffdralis        afdr
�� 
TEXT
� 
alis
�~ 
plif
�} 
utxt
�| 
pcnt�{  �z  
�y 
plii
�x 
valL
�w 
kocl
�v 
cobj
�u .corecnte****       ****
�t 
to  
�s .nnpaadtgnull���    utxt�� ��kvE�O� C #*�,�*�,l �&�%�&E�O*��&/�,E�W X  hO ���/a ,E�W X  hUO 8�[a a l kh  a  �a ��&l UW X  hOP[OY�� ascr  ��ޭ
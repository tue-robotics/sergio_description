#! /bin/bash

ROBOT_DESCRIPTION_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

# Generate urdf from xacro
rosrun xacro xacro.py -o $ROBOT_DESCRIPTION_DIR/urdf/sergio.urdf $ROBOT_DESCRIPTION_DIR/urdf/xacro/sergio.urdf.xacro

# Generate sdf from urdf
gzsdf print $ROBOT_DESCRIPTION_DIR/urdf/sergio.urdf > $ROBOT_DESCRIPTION_DIR/sdf/sergio.sdf

grep 'Error' $ROBOT_DESCRIPTION_DIR/sdf/sergio.sdf
grep 'Warning' $ROBOT_DESCRIPTION_DIR/sdf/sergio.sdf

# Remove warning messages from sdf
sed -i '/Warning/d' $ROBOT_DESCRIPTION_DIR/sdf/sergio.sdf

# Fix media paths
sed -i 's/model:\/\/amigo_description\/media/model:\/\/media/g' $ROBOT_DESCRIPTION_DIR/sdf/sergio.sdf
sed -i 's/model:\/\/sergio_description\/media/model:\/\/media/g' $ROBOT_DESCRIPTION_DIR/sdf/sergio.sdf


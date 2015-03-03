////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package mx.collections
{
    import org.flexunit.asserts.assertEquals;

    public class HierarchicalCollectionView_FLEX_34775_Tests
	{
		private static var _utils:HierarchicalCollectionViewTestUtils = new HierarchicalCollectionViewTestUtils();
		private static var _sut:HierarchicalCollectionView;
		private var _level0:ArrayCollection;
		
		[Before]
		public function setUp():void
		{
            _sut = generateHierarchyViewWithClosedNodes();
            _level0 = _utils.getRoot(_sut) as ArrayCollection;
		}
		
		[After]
		public function tearDown():void
		{
            _sut = null;
            _level0 = null;
		}



        [Test]
        public function test_navigation_after_opening_hidden_node():void
        {
            //given
            var company:DataNode = _level0.getItemAt(0) as DataNode;
            var location:DataNode = company.children.getItemAt(0) as DataNode;

            //when
            _sut.openNode(location);

            var cursor:IViewCursor = _sut.createCursor();
            var i:int = 0;
            while(!cursor.afterLast && i++ < 100)
            {
                cursor.moveNext();
            }

            //then
            assertEquals(1, i);
            assertEquals(1, _sut.length);
        }

		private static function generateHierarchyViewWithClosedNodes():HierarchicalCollectionView
		{
			return _utils.generateHCV(_utils.generateHierarchySourceFromString(HIERARCHY_STRING));
		}

		private static const HIERARCHY_STRING:String = (<![CDATA[
			Adobe
			Adobe->London
            Adobe->London->FlexDept
		]]>).toString();
	}
}
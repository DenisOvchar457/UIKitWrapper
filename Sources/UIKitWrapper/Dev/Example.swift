//
//  Example.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import SwiftUI


class ExampleVC: VC<()> {
    
    @Rx var isMenuShown: Bool = false
    
    override var content: UIView {
        V(
            __,
            circle(color: .green, rad: 100),
            circle(color: .red, rad: 300),
            UIView()[width: 150, height: 150].apply {
                $0.lines(color: .rgb(218, 85, 48), fillColor: .yellow, width: 1,
												 xy(0,0),
                         xy(100, 20),
                         xy(-100, 20),
                         xy(0, -40))
            },
            
            __
        ).chain.alignment[.center]
        
    }
    
    func circle(color: UIColor, rad: CGFloat) -> UIView {
        UIView()[color: color, width:rad*2, height:rad*2, rad: rad]
    }
    
    func tap() {
        
    }
    
    
}

struct ExampleVCPreview_Previews: PreviewProvider {
    static var previews: some View {
        ExampleVC(()).view.swiftUI
    }
}

//ImGui::Begin("My First Tool", &my_tool_active, ImGuiWindowFlags_MenuBar);
//if (ImGui::BeginMenuBar())
//{
//    if (ImGui::BeginMenu("File"))
//    {
//        if (ImGui::MenuItem("Open..", "Ctrl+O")) { /* Do stuff */ }
//        if (ImGui::MenuItem("Save", "Ctrl+S"))   { /* Do stuff */ }
//        if (ImGui::MenuItem("Close", "Ctrl+W"))  { my_tool_active = false; }
//        ImGui::EndMenu();
//    }
//    ImGui::EndMenuBar();
//}
//
//// Edit a color (stored as ~4 floats)
//ImGui::ColorEdit4("Color", my_color);
//
//// Plot some values
//const float my_values[] = { 0.2f, 0.1f, 1.0f, 0.5f, 0.9f, 2.2f };
//ImGui::PlotLines("Frame Times", my_values, IM_ARRAYSIZE(my_values));
//
//// Display contents in a scrolling region
//ImGui::TextColored(ImVec4(1,1,0,1), "Important Stuff");
//ImGui::BeginChild("Scrolling");
//for (int n = 0; n < 50; n++)
//    ImGui::Text("%04d: Some text", n);
//ImGui::EndChild();
//ImGui::End();

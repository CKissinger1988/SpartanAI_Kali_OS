import React from 'react';
import TerminalConsole from './panels/TerminalConsole';
import CloudInfrastructure from './panels/CloudInfrastructure';
import MsfSessions from './panels/MsfSessions';
import SecurityIntelligence from './panels/SecurityIntelligence';

interface MainPanelProps {
  activeTab: string;
}

export default function MainPanel({ activeTab }: MainPanelProps) {
  const renderContent = () => {
    switch (activeTab) {
      case 'chat': return <TerminalConsole />;
      case 'hosting': return <CloudInfrastructure />;
      case 'msf': return <MsfSessions />;
      case 'security': return <SecurityIntelligence />;
      default: return <div className="text-[#8e8e8e]">Panel for {activeTab} in development...</div>;
    }
  };

  return (
    <main className="flex-1 flex flex-col bg-[#0f0f0f]">
      <div className="h-12 border-b border-[#2b2b2b] flex items-center px-5 justify-between">
        <div className="text-[13px] text-[#8e8e8e]">AI Supreme_ProxMox / <span className="text-white font-medium capitalize">{activeTab}</span></div>
      </div>
      <div className="flex-1 overflow-y-auto p-8">
        {renderContent()}
      </div>
    </main>
  );
}

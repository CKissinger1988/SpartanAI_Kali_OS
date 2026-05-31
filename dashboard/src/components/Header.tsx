export default function Header() {
  return (
    <header className="h-10 bg-[#0f0f0f] border-b border-[#2b2b2b] flex items-center px-4 gap-4 text-[13px] font-medium">
      <div className="text-white">Antigravity</div>
      <div className="text-[#8e8e8e] cursor-pointer">File</div>
      <div className="text-[#8e8e8e] cursor-pointer">View</div>
      <div className="text-[#8e8e8e] cursor-pointer">Window</div>
      {/* Telemetry stats would go here */}
    </header>
  );
}

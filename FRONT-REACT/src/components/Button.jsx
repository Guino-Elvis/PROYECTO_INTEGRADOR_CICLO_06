const Button = ({ onClick, className, title }) => {
    return (
        <button style={{ borderRadius: "10px"}}
            className={className}
            onClick={onClick}
        >
            {title}
        </button>
    )
}
export default Button;